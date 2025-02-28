FROM condaforge/mambaforge:24.9.2-0

RUN echo "channels:" > ~/kbo_paper.yml
RUN echo "  - bioconda" >> ~/kbo_paper.yml
RUN echo "  - conda-forge" >> ~/kbo_paper.yml
RUN echo "dependencies:" >> ~/kbo_paper.yml
RUN echo "  - kbo-cli=0.1.1" >> ~/kbo_paper.yml
RUN echo "  - ska2=0.3.11" >> ~/kbo_paper.yml
RUN echo "  - snippy=4.6.0" >> ~/kbo_paper.yml

RUN mamba init zsh
RUN mamba update -y -n base -c conda-forge conda=25.1.1
RUN mamba env create -y -n kbo_paper -f ~/kbo_paper.yml

COPY . /mnt

CMD . ~/.zshrc && \
    mamba activate kbo_paper && \
    kbo --version && \
    ska --version && \
    snippy --version
