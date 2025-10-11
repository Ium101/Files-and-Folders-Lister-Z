# User Manual - Files and Folders Lister Z

<h3 align="center">
  <a href="#english">English</a> • <a href="#português-brasil">Português (Brasil)</a>
</h3>

---

## English

### Table of Contents
1.  [Overview](#overview)
2.  [How to Use](#how-to-use)
    -   [Using the GUI](#1-using-the-gui)
    -   [Using the Command Line](#2-using-the-command-line)
3.  [Features](#features)
4.  [Notes](#notes)
5.  [Enterprise Edition](#enterprise-edition)

### Overview
Files and Folders Lister Z or simply Lister Z is a utility for listing the contents of directories on your computer. It provides both a command-line and a graphical user interface (GUI) for easy use.
It can also create folders and empty text files in the same structure as a selected JSON file.

### How to Use

#### Multi-language Support
Both the GUI and CLI versions support English and Brazilian Portuguese. In the GUI, there are two main buttons: "Executar Listador de Pastas e Arquivos Z" (Brazilian Portuguese, above) and "Run Files & Folders Lister Z" (English, below).

#### 1. Using the GUI
**Windows:**
-   Double-click `lister_z_gui.exe` to launch the graphical interface. The GUI shows both language buttons as described above.

**Linux:**
-   Run the shell script:
    ```bash
    ./run_lister_z_gui.sh
    ```
**MacOS:**
-   Double-click `Lister Z GUI.command`. The GUI features are identical to the Windows version, including both language buttons.

Select the folder you want to list using the provided options. Choose your desired output format (DOCX, TXT, or JSON). Click either main button to generate the list in your preferred language.

#### 2. Using the Command Line
**Windows:**
-   Open a command prompt or PowerShell window.
-   Run the script with Python:
    ```bash
    python lister_z.py
    ```
-   Or use the provided batch file:
    ```bash
    run_lister_z.cmd
    ```
The program will prompt you to select your language and guide you through the options.

**Linux:**
-   Run the shell script:
    ```bash
    ./run_lister_z.sh
    ```
You will be prompted for language selection and options.

**MacOS:**
-   Double-click `Lister Z.command` and follow the language prompt.

Follow the on-screen prompts to specify the folder and output options in your chosen language.

### Features
-   List all files and folders in a selected directory.
-   Export results to various formats.
-   Simple and intuitive interface.

### Notes
-   Requires Python to run the `lister_z.py` and `lister_z_gui.py` scripts.
-   For the GUI version on Windows, use the `lister_z_gui.exe` file for convenience (no Python required).
-   For Linux, use the provided launch scripts: `run_lister_z.sh`, or `run_lister_z_gui.sh`.
-   For MacOS, use the provided launch scripts: `Lister Z.command`, or `Lister Z GUI.command`.

### Enterprise Edition
-   Does NOT include credits in the output files (DOCX / TXT / JSON).

See `README.md` for more details. For support or more information, refer to the project README or contact Ium101.

---

## Português (Brasil)

### Índice
1.  [Visão Geral](#visão-geral)
2.  [Como Usar](#como-usar)
    -   [Usando a GUI](#1-usando-a-gui-1)
    -   [Usando a Linha de Comando](#2-usando-a-linha-de-comando-1)
3.  [Funcionalidades](#funcionalidades)
4.  [Observações](#observações)
5.  [Versão Empresarial](#versão-empresarial)

### Visão Geral
Listador de Pastas e Arquivos Z ou simplesmente Listador Z é um utilitário para listar o conteúdo de diretórios no seu computador. Ele oferece tanto uma interface de linha de comando quanto uma interface gráfica (GUI) para facilitar o uso.
Também pode criar pastas e arquivos de texto vazios com nomes na mesma estrutura do arquivo JSON a ser selecionado.

### Como Usar

#### Suporte a Múltiplos Idiomas
Tanto a versão GUI quanto a CLI suportam inglês e português brasileiro. Na GUI, há dois botões principais: "Executar Listador de Pastas e Arquivos Z" (português brasileiro, acima) e "Run Files & Folders Lister Z" (inglês, abaixo).

#### 1. Usando a GUI
**Windows:**
-   Clique duas vezes em `lister_z_gui.exe` para abrir a interface gráfica. A GUI mostra ambos os botões de idioma conforme descrito acima.

**Linux:**
-   Execute o script:
    ```bash
    ./run_lister_z_gui.sh
    ```
**MacOS:**
-   Clique duas vezes em `Lister Z GUI.command`. A GUI é idêntica à versão Windows, incluindo ambos os botões de idioma.

Selecione a pasta que deseja listar usando as opções fornecidas. Escolha o formato de saída desejado (DOCX, TXT ou JSON). Clique em qualquer botão principal para gerar a lista no idioma preferido.

#### 2. Usando a Linha de Comando
**Windows:**
-   Abra o Prompt de Comando ou PowerShell.
-   Execute o script com Python:
    ```bash
    python lister_z.py
    ```
-   Ou use o arquivo batch fornecido:
    ```bash
    run_lister_z.cmd
    ```
O programa solicitará a seleção de idioma e guiará você pelas opções.

**Linux:**
-   Execute o script:
    ```bash
    ./run_lister_z.sh
    ```
Você será solicitado a selecionar o idioma e as opções.

**MacOS:**
-   Clique duas vezes em `Lister Z.command` e siga o prompt de idioma.

Siga as instruções na tela para especificar a pasta e as opções de saída no idioma escolhido.

### Funcionalidades
-   Lista todos os arquivos e pastas em um diretório selecionado.
-   Exporta resultados para vários formatos.
-   Interface simples e intuitiva.

### Observações
-   Requer Python para executar os scripts `lister_z.py` e `lister_z_gui.py`.
-   Para a versão GUI no Windows, use o arquivo `lister_z_gui.exe` para maior comodidade (não é necessário Python).
-   Para Linux, use os scripts de inicialização fornecidos: `run_lister_z.sh` ou `run_lister_z_gui.sh`.
-   Para MacOS, use os scripts de inicialização fornecidos: `Lister Z.command` ou `Lister Z GUI.command`.

### Versão Empresarial
-   Não inclui créditos nos arquivos de saída (DOCX / TXT / JSON).

Veja o `README.md` para mais detalhes. Para suporte ou mais informações, consulte o README do projeto ou entre em contato com Ium101.
