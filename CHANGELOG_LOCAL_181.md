# Change Log
Todas as alterações no projeto estão listadas neste arquivo.

Disclaimer: pode ser notada um grande espaçamento entre algumas das datas entre atualizações do projeto e isto é dado devido o fato de que quando estava produzindo o mesmo passei por dificuldades e problemas pessoais e durante alguns momentos tive de parar com o projeto, mesmo assim tive forças e empenho para continuá-lo, peço que veja com carinho. caza

- [Unreleased](#unreleased---08122022-2022-12-08)
    - [Próximos passos](#proximos-passos)
- [1.0.2](#102---08122022-2022-12-08)
- [1.0.1](#101---08122022-2022-12-08)
- [1.0.0](#100---07122022-2022-12-07)
 
## [Unreleased] - 08/12/2022 (2022-12-08)
 
### Próximos passos:
- Realizar testes com usuários em busca de possíveis erros ou falhas no aplicativo
    - Concertos de possíveis erros vindos dos testes
- Resolução de por menores listados no trello
- Refatoração e organização do código usando como base boa práticas e regras de código limpo
- Estudo e realização de testes de software no código e no aplicativo
- Reformulação do layout
- Segunda refatoração de código (com o intuito de remover possíveis problemas criados ao trocar partes do layout ou advindas de outras alterações)
- Segunda aplicação de testes no código
- Segunda Leva de testes com usuários
    - Resolução de problemas ou melhorias vindas dos testes com usuários
- Conclusão das mudanças
- Criação do Readme.md
- Conclusão do projeto

## [1.0.2] - 08/12/2022 (2022-12-08)

Este release é simbólico, a minha ideia com ele é apenas adicionar a alteração no Readme

### 08/12/2022
- Alterado o Readme do projeto

## [1.0.1] - 08/12/2022 (2022-12-08)

Este release é simbólico, a minha ideia com ele é apenas adicionar este documento de changelog

### 08/12/2022
- Adicionado changelog do projeto

## [1.0.0] - 07/12/2022 (2022-12-07)

Primeira versão efetiva do aplicativo, funcionando de maneira parcialmente fluida porém ainda necessita melhores alterações

Nota: Alterações até aqui estão separadas por data afinal ate aqui o aplicativo não possuia uma versão efetiva, atualizações posteriores a esta seguiram organização padrão de changelog

### 07/12/2022 - Efetuada a Release 1.0.0
- Testes simples com amigos usando o aplicativo
- Resolução de erro onde o usuário podia seguir a si mesmo
- Usuario tem um feedback visual ao seguir alguém na tela de busca de seguidores/seguindo
- O Aplicativo retorna ao feed da home antes de fechar caso o usuário aperte o botão de retornar do aparelho
- Agora o usuário tem que confirmar sua senha ao criar a sua conta

### 06/12/2022
- Implementando feed da tela principal
- Tela de feed inicial implementado usando os mesmos recursos do feed de postagens de um usuário com o adicional de puxar para baixo para atualizar
- Removido trecho de código que ocasionava em um erro

### 05/12/2022
- Tela de comentários funcionando, agora é possível enviar e ver comentários desta postagem
- Agora é possível dar curtidas em comentários
- Comentários com maior número de curtidas aparecem por cima

### 02/12/2022
- Criação do "Modelo" de comentários para facilitar a manipulação dos dados
- Aplicativo agora permite o envio de comentários em uma postagem

### 01/12/2022
- Preparando informações para a tela de comentários

### 30/11/2022
- Agora o usuário pode seguir ou deixar de seguir usuário pela tela de busca de seguidores/seguindo
- Usuário também pode remover um seguidor pela tela de busca de seguidores/seguindo

### 29/11/2022
- Tela de busca de Seguindo/Seguidores de um usuários já esta funcionando exibindo os usuários baseado em sua pesquisa

### 24/11/2022
- Criando a tela de busca baseado em uma string ou na ausência da mesma
- Aplicativo já realiza a busca e traz para o aplicativo porém ainda não exibe os mesmo na tela

### 23/11/2022
- Usuário logado agora pode Excluir postagens
- Usuário logado pode editar suas postagens e salvar suas alterações

### 22/11/2022
- Agora é possível curtir postagens
- Agora é possível salvar postagens para que a mesma apareça em seu perfil
- Template da tela de comentários criada

### 21/11/2022
- Aplicativo agora permite o usuário compartilhar uma imagem de uma postagem
- Agora é possível acessar perfis de outros usuarios

### 18/11/2022
- Agora o aplicativo envia a lista de postagens corretamente e o mesmo já exibe a mesma e posiciona na imagem que o usuário clicou

### 17/11/2022
- Aplicativo tras as informações do firebase e já exibe os mesmos nos cards devidamente

### 16/11/2022
- Criado a tela de feed de postagens do perfil
- Clicar em uma imagem agora redireciona o usuário para o feed de postagens
- Agora o aplicativo salva imagens no firebase usando como nome o seu id para evitar possíveis erros futuros
- Layout e parte do card de exibição de postagens na tela de feed de postagens criado

### 14/11/2022
- Consertado o erro onde o aplicativo impossibilitava o usuário de finalizar a alteração de perfil caso ele não trocasse sua foto
- Consertado o erro onde a imagem de perfil era exibida como uma mensagem de erro ou não era exibida
- O aplicativo traz um feedback para o usuário após realizar o upload de uma nova imagem de perfil

### 27/10/2022
- Aplicativo agora possibilita o usuário efetivamente realizar alterações em suas informações de perfil

### 26/10/2022
- Criação da tela de edição de perfil de usuário
- Aplicativo agora exibe dos dados do usuário na tela de edição de perfil porém ainda não possibilita sua edição

### 25/10/2022
- Usuário agora é redirecionado para uma tela de busca ao clicar nos números de seguindo e seguidores no perfil
- Corrigido erro que um upload não tinha seu ID registrado na base de dados
- Agora o aplicativo exibe as postagens de um perfil
- Agora ao clicar em publicações a tela centraliza nas mesmas
- Correções de código para facilitar o entendimento

### 24/10/2022
- Criação da Tela de postagem de imagens
- Implementado o sistema de seleção de imagens para postagem
- Tela de postagem de imagens criado e funcionando

### 18/10/2022
- Exibição de informações e imagens placeholder caso o usuário não possua informações

### 27/09/2022 e 28/09/2022
- Implementada a exibição dos dados vindos do firebase
- Organização do Layout

### 26/09/2022
- Título da App Bar agora se adapta a aba da Navigation bar e exibe o nome de usuario caso o mesmo esteja na tela de perfil
- Sistema de Logout do aplicativo foi transferido para o controlador global
- Abas do Navigation Bar agora são tratadas como "Stateful Widgets" para facilitar a manipulação
- Alterada a maneira que a tela principal transita informações entre as Abas
- Tela de perfil alterada para exibir o perfil baseado no id do mesmo recebido ao acessar a tela. O intuito aqui é que a tela possa se adaptar para qualquer perfil auxiliando em uma possível reutilização
- Aplicativo já efetua a busca e carrega todas a informações restando apenas exibi las na tela

### 23/09/2022
- Layout da tela de perfil criado
- Preparação para tela de perfil receber dados do Firebase

### 22/09/2022
- Alteração de sistema de telas para a home do aplicativo
- Implementado sistema de "Navigation Bar" onde a tela inicial consiste em um tela única dividida em três abas: Feed, Pesquisa e Perfil
- Organizando novo sistema de Navigation Bar
- Criação básica de layout para tela de perfil

### 21/09/2022
- Corrigidos erros onde o usuario logado não era enviado para a tela de home

### 13/09/2022
- Criação da tela de recuperação de conta
- Implementação de controlador global para casos de métodos duplicados e muito usado
- Tela de recuperação de conta implementada e funcionando corretamente
- Tela de feedback Criada porem ainda não envia dados para o Firebase

### 12/09/2022
- Corrigidos erros na criação de contas
- Aplicativo agora traz um feedback para o usuário que criou a conta após a mesma
- Implementada verificação de conta criada
- Implementada verificação de conta existente

### 08/09/2022
- Implementada a criação de contas na base de dados
- Corrigido erros de conflito com o Firebase
- Correção de erros menores no projeto

### 24/08/2022
- Criação e organização da classe model de usuários do projeto

### 19/08/2022
- Tela de criação de contas ja esta funcionando porem ainda não cria contas efetivamente devido a falta de um "model" para organizar e facilitar o processo
- Organização de nomes de variáveis do projeto

### 18/08/2022
- Tela de login agora funciona corretamente transferindo o usuario logado de tela
- Remoção de erros menores no código do projeto

### 17/08/2022
- Tela e funções de login implementadas no aplicativo
- Tela de login ja efetua o mesmo porem ainda não sofre alterações
- Transição para tela de "criação de conta" e "esqueci minha senha" adicionada

### 16/08/2022
- Implementação da tela de introdução do aplicativo
- Tela de introdução agora verifica se um usuários esta logado e caso esteja o transfere diretamente para a tela de home do app

### 14/08/2022 a 15/08/2022
- Preparação e implementação do Firebase no projeto
- Testes de configuração do Firebase no projeto
- Implementação constantes e classes para organização do Firebase no projeto

### 01/08/2022 a 02/08/2022 e 08/08/2022 a 09/08/2022
- Organização da area de trabalho e ambiente
- Instalação de ferramentas
- Organização de Git e Trello
- Implementação de estrutura base do projeto
- Padrão de projeto escolhido e inicio da implementação