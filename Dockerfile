FROM texlive/texlive:latest

WORKDIR /rapport

COPY . .

RUN pdflatex -interaction=nonstopmode main.tex

CMD ["pdflatex", "-interaction=nonstopmode", "main.tex"]
