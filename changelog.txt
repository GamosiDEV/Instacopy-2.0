- Versão 1.0.1
Primeira versão efetiva do aplicativo, funcionando de maneira parcialmente fluida porem ainda necessita melhores alterações

08/12/2022
- Desição dos proximos passos

07/12/2022 - Efetuada a Release 1.0.0
- Testes simples com amigos usuando o aplicativo
- Resolução de erro onde o usuario podia seguir a si mesmo
- Usuario tem um feedback visual ao seguir alguem na tela de busca de seguidores/seguindo
- O Aplicativo retorna ao feed da home antes de fechar caso o usuario aperte o botão de retornar do aparelho
- Agora o usuario tem que confirmar sua senha ao criar a sua conta

06/12/2022
- Implementando feed da tela principal
- Tela de feed inicial implementado usuando os mesmos recursos do feed de postagens de um usuario com o adicional de puxar para baixo para atualizar
- Removido trexo de codigo que ocasionava em um erro

05/12/2022
- Tela de comentarios funcionando, agora é possivel enviar e ver comentarios de uma postagem
- Agora é possivel dar curtidas em comentarios
- Comentarios com maior numero de curtidas aparecem por cima

02/12/2022
- Criação do "Model" de comentarios para facilitar a manipulação dos dados
- Aplicativo agora permite o envio de comentarios em uma postagem

01/12/2022
- Preparando informações para a tela de comentarios

30/11/2022
- Agora o usuario pode seguir ou deixar de seguir usuario pela tela de busa de seguidores/seguindo
- Usuario tambem pode remover um seguidor pela tela de busca de seguidores/seguindo

29/11/2022
- Tela de busca de Seguindo/Seguidores de um usuarios ja esta funcionando exibindo os usuarios baseado em sua pesquisa

24/11/2022
- Criando a tela de busca baseado em uma string ou na ausencia da mesma
- Aplicativo ja realiza a busca e traz para o aplicativo porem ainda não exibe os mesmo na tela

23/11/2022
- Usuario logado agora pode Excluir postagens
- Usuario logado pode editar suas postagens e salvar suas alterações

22/11/2022
- Agora é possivel curtir postagens
- Agora é possivel salvar postagens para que a mesma apareça em seu perfil
- Template da tela de comentarios criada

21/11/2022
- Aplicativo agora permite o usuario compartilhar uma imagem de uma postagem
- Agora é possivel acessar perfis de outros usuarios

18/11/2022
- Agora o aplicativo envia a lista de postagens corretamente e o mesmo ja exibe a mesma e posiciona na imagem que o usuario clicou

17/11/2022
- Aplicativo tras as informações do firebase e ja exibe os mesmos nos cards devidamente

16/11/2022
- Criado a tela de feed de postagems do perfil
- Clicar em uma imagem agora redireciona o usuario para o feed de postagens
- Agora o aplicativo salva imagens no firebase usando como nome o seu id para evitar possiveis erros futuros
- Layout e parte do card de exibição de postagens na tela de feed de potagens criado

14/11/2022
- Concertado o erro onde o aplicativo impossibilitava o usuario de finalizar a alteração de perfil caso ele não trocasse sua foto
- Concertado o erro onde a imagem de perfil era exibida como uma mensagem de erro ou não era exibida
- O aplicativo traz um feedback para o usuario apos realizar o upload de uma nova imagem de perfil

27/10/2022
- Aplicativo agora possibilita o usuario efetivamente realizar alterações em suas informações de perfil

26/10/2022
- Criação da tela de edição de perfil de usuario
- Aplicativo agora exibe dos dados do usuario na tela de edição de peprfil porem ainda não possibilita sua edição

25/10/2022
- Usuario agora é redirecionado para uma tela de busca ao clicar nos numeros de seguindo e seguidores no perfil
- Corrigido erro que um upload não tinha seu ID registrado na base de dados
- Agora o aplicativo exibe as postagens de um perfil
- Agora ao clicar em publicações a tela centraliza nas mesmas
- Correções de codigo para facilitar o entendimento

24/10/2022
- Criação da Tela de postagem de imagens
- Implementado o sistema de seleção de imagens para postagem
- Tela de postagem de imagens criado e funcionando

18/10/2022
- Exibição de informações e imagens placeholder caso o usuario não possua informações

27/09/2022 e 28/09/2022
- Implementada a exibição dos dados vindos do firebase
- Organização do Layout

26/09/2022
- Titulo da App Bar agora se adapta a aba da Navigation bar e exibe o nome de usuario caso o mesmo esteja na tela de perfil
- Sistema de Logout do aplicativo foi transferido para o controlador global
- Abas do Navigation Bar agora são tratadas como "Stateful Widgets" para facilitar a manipulação
- Alterada a maneira que a tela principal transita informações entre as Abas
- Tela de perfil alterada para exibir o perfil baseado no id do mesmo recebido ao acessar a tela. O intuito aqui é que a tela possa se adaptar para qualquer perfil auxiliando em uma possivel reutilização
- Aplicativo ja efetua a busca e carrega todas a informações restando apenas exibilas na tela

23/09/2022
- Layout da tela de perfil criado
- Preparação para tela de perfil receber dados do Firebase

22/09/2022
- Alteração de sistema de telas para a home do aplicativo
- Implementado sistema de "Navigation Bar" onde a tela incial consiste em um tela unica dividida em treis abas: Feed, Pesquisa e Perfil
- Organizando novo sistema de Navigation Bar
- Criação basica de layout para tela de perfil

21/09/2022
- Corrigidos erros onde o usuario logado não era enviado para a tela de home

13/09/2022
- Criação da tela de recuperação de conta
- Implementação de controlador global para casos de metodos duplicados e muito usado
- Tela de recuperação de conta implementada e funcionando corretamente
- Tela de feedback Criada porem ainda não envia dados para o Firebase

12/09/2022
- Corrigidos erros na criação de contas
- Aplicativo agora traz um feedback para o usuario que criou a conta apos a mesma
- Implementada verificação de conta criada
- Implementada verificação de conta existente

08/09/2022
- Implementada a criação de contas na base de dados
- Corrigido erros de conflito com o Firebase
- Correção de erros menores no proejto

24/08/2022
- Criação e organização da classe model de usuarios do projeto

19/08/2022
- Tela de criação de contas ja esta funcionando porem ainda não cria contas efetivamente devido a falta de um "model" para organizar e facilitar o processo
- Organização de nomes de variaveis do projeto

18/08/2022
- Tela de login agora funciona corretamente transferindo o usuario logado de tela
- Remoção de erros menores no codigo do projeto

17/08/2022
- Tela e funções de login implementadas no aplicativo
- Tela de login ja efetua o mesmo porem ainda não sofre alterações
- Transição para tela de "criação de conta" e "esqueci minha senha" adicionada

16/08/2022
- Implementação da tela de introdução do aplicativo
- Tela de introdução agora verifica se um usuarios esta logado e caso esteja o transfere diretamente para a tela de home do app

14/08/2022 a 15/08/2022
- Preparação e implementação do Firebase no projeto
- Testes de configuração do Firebase no projeoto
- Implementação constantes e classes para organização do Firebase no projeto

01/08/2022 a 02/08/2022 e 08/08/2022 a 09/08/2022
- Organização da area de trabalho e ambiente
- Instalação de ferramentas
- Organização de Git e Trello
- Implementação de estrutura base do projeto
- Padrão de projeto escolhido e inicio da implementação