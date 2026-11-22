# 📋 CheckPro — Sistema Industrial de Checklist Diário

![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen)
![React](https://img.shields.io/badge/React-18-blue?logo=react)
![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-3-38B2AC?logo=tailwind-css)
![Android](https://img.shields.io/badge/Android-Capacitor_APK-3DDC84?logo=android)

Aplicação web e mobile desenvolvida para **inspeção preventiva diária de máquinas e equipamentos industriais**. O sistema substitui fichas de papel no chão de fábrica por um fluxo digital rápido, com controle de acesso por perfil, registro estruturado de Não Conformidades (NC), histórico agrupado por data e script automatizado de empacotamento para Android (`.apk`).

---

## 🎯 Problema Resolvido

Em ambientes industriais, inspeções diárias em papel dificultam a rastreabilidade de falhas, atrasam a identificação de equipamentos críticos e geram perda de histórico. O **CheckPro** resolve isso oferecendo:
* Preenchimento guiado com ícones visuais para rápida leitura operacional
* Classificação padronizada de falhas (**Conforme**, **Não Conforme** e **Não Aplicável**)
* Consulta instantânea de histórico filtrado por data, equipamento ou status de falha
* Operação offline-first utilizando armazenamento local (`localStorage`), ideal para áreas fabris com sinal instável

---

## ✨ Funcionalidades Principais

* **🔐 Autenticação e Controle de Acesso (RBAC):**
  * Tela de login e cadastro de novos operadores com geração automática de usuário (`nome.sobrenome`)
  * Separação de permissões entre **Operador (`comum`)** e **Administrador (`admin`)**
  * Credenciais padrão para demonstração: `master` / `master`
* **🏭 Fichas de Inspeção por Equipamento:**
  * Checklists específicos para **Bomba Duplo Diafragma**, **Misturador Industrial**, **Compressor de Ar**, **Unidade de Jateamento**, **Guincho Elétrico** e **Pórtico Rolante**
* **⚠️ Gestão Inteligente de Não Conformidades (NC):**
  * Ao marcar um item como *Não Conforme*, um seletor exibe causas técnicas recorrentes (vazamento, desgaste, falta de EPI, ruído anormal, etc.) ou libera um campo de texto livre para detalhamento
* **📅 Histórico Agrupado e Relatório Tabular:**
  * Registros organizados em árvore cronológica expansível por data
  * Busca dinâmica por equipamento, data ou operador, além de filtros exclusivos para apontamentos `NC` ou `NA`
  * Visualização completa em formato de ficha técnica oficial de inspeção
* **🛠️ Painel Administrativo & Manual Integrado:**
  * Redefinição de senhas de operadores, alternância de privilégios (`admin`/`comum`) e exclusão de registros
  * Guia interativo integrado diretamente na interface

---

## 🚀 Tecnologias Utilizadas

* **Frontend:** HTML5, CSS3, JavaScript (ES6+), React 18, Babel Standalone
* **Estilização:** Tailwind CSS & Google Fonts (`Inter`)
* **Persistência:** Web Storage API (`localStorage`)
* **Mobile / Build:** Capacitor CLI & Android Gradle (via automação Batch `.bat`)

---

## 💻 Como Executar o Projeto

### 1. Rodar no Navegador (Web)
Não requer instalação de servidor ou dependências:
1. Clone este repositório ou baixe os arquivos.
2. Abra o arquivo `index.html` diretamente no navegador.
3. Acesse com o login de demonstração:
   * **Usuário:** `master`
   * **Senha:** `master`

### 2. Gerar o Aplicativo Android (`.apk`)
O projeto conta com um script automatizado para Windows (`gerar_apk.bat`) que verifica e instala as dependências necessárias (`Node.js`, `Java JDK 17`, `Android SDK` e `Capacitor`) e compila o aplicativo:
1. Execute o arquivo `gerar_apk.bat`.
2. Aguarde a verificação/instalação do ambiente e a compilação via Gradle.
3. Ao final, o arquivo `checkpro-checklist-debug.apk` será gerado na raiz da pasta.

---

## 📁 Estrutura de Arquivos

```text
├── index.html       # Aplicação completa (Interface, lógica React e regras de negócio)
├── MANUAL.md        # Documentação funcional para operadores e administradores
├── gerar_apk.bat    # Script automatizado de setup de ambiente e build Android APK
└── README.md        # Documentação técnica do projeto
