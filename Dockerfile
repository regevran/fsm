FROM gcc:latest

LABEL maintainer = "Ran Regev <regev.ran@gmail.com>"

RUN apt-get update && \
    apt-get install -y \    
    clang-format \
    clang-tidy \
    ccache \
    pandoc \
    python3-venv \
    texlive-xetex \
    vim \
    python-pip && \
    pip install conan cmake