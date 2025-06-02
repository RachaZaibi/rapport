FROM ghcr.io/xu-cheng/texlive-full:latest

WORKDIR /data

COPY . /data

# Install PlantUML and dependencies
RUN (command -v apk && apk add --no-cache graphviz wget curl) || \
    (command -v apt-get && apt-get update && apt-get install -y graphviz wget curl) || \
    (echo "No supported package manager found, please install graphviz and wget manually" && exit 1) && \
    mkdir -p /usr/local/bin && \
    wget -O /usr/local/bin/plantuml.jar https://github.com/plantuml/plantuml/releases/download/v1.2024.4/plantuml-1.2024.4.jar && \
    echo -e '#!/bin/sh\njava -jar /usr/local/bin/plantuml.jar "$@"' > /usr/local/bin/plantuml && \
    chmod +x /usr/local/bin/plantuml

# Install plantuml LaTeX package properly
RUN tlmgr update --self && \
    tlmgr install plantuml && \
    mktexlsr

CMD ["latexmk", "-pdf", "main.tex"]
# docker run --rm -v ${PWD}:/data -w /data rapport-latex pdflatex main.tex