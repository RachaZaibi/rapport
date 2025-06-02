FROM ghcr.io/xu-cheng/texlive-full:latest

WORKDIR /data

COPY . /data

CMD ["pdflatex", "main.tex"]
