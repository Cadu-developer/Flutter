# Comentários em Tempo Real — Flutter + Firebase

## Correções incluídas
- Comentários salvos em `publicacoes/{publicacaoId}/comentarios`.
- Cada comentário guarda texto, nome, UID, ID da publicação e data.
- `StreamBuilder` escuta `snapshots()` do Firestore para atualizar a conversa em tempo real.
- A interface só mostra a opção de excluir nos comentários do usuário atual.
- O serviço também verifica a autoria antes de excluir.
- Teste antigo corrigido: ele tentava instanciar `MyApp` e testar um contador inexistente.
- Adicionado `firestore.rules` para restringir exclusão aos autores.

## Configuração obrigatória do Firebase
O ZIP original não continha as credenciais/configurações do Firebase (por exemplo, `google-services.json`, `GoogleService-Info.plist` ou um `firebase_options.dart` gerado). Não é possível inventar esses dados. Configure o projeto com a sua conta Firebase antes de executar:

1. Abra o terminal na pasta `comentarios`.
2. Execute:
   ```bash
   flutter pub get
   dart pub global activate flutterfire_cli
   npm install -g firebase-tools
   firebase login
   dart pub global run flutterfire_cli:flutterfire configure
   ```
3. No console do Firebase, habilite **Authentication > Sign-in method > Email/Password** e crie um banco **Cloud Firestore**.
4. Confirme que `lib/firebase_options.dart` foi substituído pelo arquivo gerado pelo comando. Se não foi, repita a configuração selecionando a plataforma correta.
5. Publique as regras do arquivo `firestore.rules` no Firestore (Firebase Console > Firestore Database > Rules), ou adapte-as se o app tiver outras operações que precisem de permissões.
6. Execute:
   ```bash
   flutter run
   ```

O arquivo `lib/firebase_options.dart` incluído é apenas um marcador temporário e será substituído pelo FlutterFire CLI. O app não se conectará ao Firebase até você executar o comando de configuração.

## Como os comentários são organizados
Cada publicação tem sua própria subcoleção `comentarios`. Assim, comentários de publicações diferentes ficam separados. O `StreamBuilder` ouve a subcoleção da publicação aberta e redesenha a lista quando o Firestore emite alterações.

## Observação sobre regras
As regras fornecidas permitem leitura apenas para usuários autenticados, criação de comentários autenticados e exclusão somente pelo UID do autor. Elas também validam que o `publicacaoId` enviado corresponde à publicação da subcoleção. Teste as regras no Firebase Emulator/console antes de publicar.
