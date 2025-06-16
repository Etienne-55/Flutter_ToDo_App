# Aplicativo de Tarefas

Um aplicativo de tarefas baseado em Flutter para gerenciar suas atividades diárias.

## Integrantes do Grupo

- Etienne Pedro Pautet
- Fabiano Quirino
- João Pedro Araújo Inácio
- Renan Chacon

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes itens instalados:

- Flutter (3.0 ou superior)
- Android Studio ou VS Code
- Android SDK (API level 21 ou superior)
- Git

## Instalação e Configuração

### 1. Clonar o Repositório
```bash
git clone https://github.com/Etienne-55/Flutter_ToDo_App.git
cd Flutter_ToDo_App
```

### 2. Instalar Dependências
```bash
flutter pub get
```

### 3. Configurar Android
Certifique-se de ter um dispositivo Android conectado ou um emulador rodando:
```bash
flutter devices
```

### 4. Executar o App
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
├── main.dart              # Ponto de entrada do app
├── models/               # Modelos de dados (Todo, User)
├── screens/              # Telas da UI (Login, Home, etc.)
├── widgets/              # Componentes de UI reutilizáveis
├── services/             # Serviços de API/Banco de dados
└── utils/                # Funções auxiliares e constantes
```

## Gerar APK

Para gerar um APK de release:
```bash
flutter build apk --release
```

O APK estará localizado em: `build/app/outputs/flutter-apk/app-release.apk`
