# Use uma imagem base do Jupyter
FROM jupyter/base-notebook:latest

# Mude para o usuário root para instalar pacotes e modificar usuários
USER root

# Instale as dependências do sistema necessárias, incluindo o git e sudo
RUN apt-get update && \
    apt-get install -y \
    pkg-config \
    libhdf5-dev \
    git \
    sudo \
    gcc

# Crie um usuário com senha e permissões sudo
RUN useradd -ms /bin/bash wolfx && \
    echo "wolfx:wolfx" | chpasswd && \
    usermod -aG sudo wolfx

# Mude para o novo usuário
USER jovyan

# Instale o notebook
RUN pip install --no-cache-dir notebook

# Copie o arquivo de requisitos para o diretório do usuário
COPY requirements.txt /home/jovyan/

# Instale os pacotes a partir do requirements.txt
RUN pip install --no-cache-dir -r /home/jovyan/requirements.txt

# Copie o arquivo de configuração, se necessário
COPY jupyter_notebook_config.py /etc/jupyter/

# Copie as pastas 'models' e 'notebooks' para o diretório de trabalho do usuário no container
COPY models /home/jovyan/work/models
COPY notebooks /home/jovyan/work/notebooks

# Exponha a porta padrão do Jupyter
EXPOSE 8888

# Defina o comando padrão para iniciar o Jupyter
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.notebook_dir='/home/jovyan/work'"]


# Instale os pacotes a partir do requirements.txt
RUN pip install --no-cache-dir -r /home/jovyan/requirements.txt

# Copie o arquivo de configuração, se necessário
COPY jupyter_notebook_config.py /etc/jupyter/

# Exponha a porta padrão do Jupyter
EXPOSE 8888

# Defina o comando padrão para iniciar o Jupyter
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.notebook_dir='/home/wolfx/work'"]
