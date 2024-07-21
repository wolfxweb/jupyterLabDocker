from notebook.notebookapp import NotebookApp

# Crie uma configuração
c = NotebookApp.config_class()

# Defina uma senha para o Jupyter Notebook
from notebook.auth.security import passwd
c.NotebookApp.password = passwd('your_password')

# Não abre o navegador automaticamente ao iniciar
c.NotebookApp.open_browser = False

# Define o diretório de trabalho padrão
c.NotebookApp.notebook_dir = '/notebooks'

# Define a porta para o Jupyter Notebook
c.NotebookApp.port = 8888
