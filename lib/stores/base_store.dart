import "dart:math";

import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:mobx/mobx.dart";

part "base_store.g.dart";

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  bool loading = false;

  @action
  void turnLoading() => loading = !loading;

  @observable
  bool jornada = false;

  @observable
  int warnings;

  @observable
  bool online = true;

  @action
  void setWarnings(value) => warnings += value;
  @observable
  String nome;

  @action
  setNome(value)=>nome=value;

  @observable
  String vencimentoCNH;

  @action
  setCNH(value)=>vencimentoCNH=value;

  @observable
  String telefone;

  @action
  setTelefone(value)=>telefone=value;

  @observable
  String email;

  @action
  setEmail(value)=>email=value;

  String cpf;
  String cnpj;
  String nomeEmpresa;
  double odometro;
  double mediaProposta;

  @action
  void setOdometro(value) => odometro = value;

  Future<void> showMyDialog(context, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alerta"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
  Random _rnd = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permantly denied, we cannot request permissions.");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error("Location permissions are denied (actual value: $permission).");
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void showTerms(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Termos de uso"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("""POLÍTICA DE PRIVACIDADE
SEÇÃO 1 - INFORMAÇÕES GERAIS


A presente Política de Privacidade contém informações sobre coleta, uso, armazenamento, tratamento e proteção dos dados pessoais dos usuários e visitantes do aplicativo Gefrot, com a finalidade de demonstrar absoluta transparência quanto ao assunto e esclarecer a todos interessados sobre os tipos de dados que são coletados, os motivos da coleta e a forma como os usuários podem gerenciar ou excluir as suas informações pessoais.

Esta Política de Privacidade aplica-se a todos os usuários e visitantes do aplicativo Gefrot  e integra os Termos e Condições Gerais de Uso do aplicativo Gefrot .

O presente documento foi elaborado em conformidade com a Lei Geral de Proteção de Dados Pessoais (Lei 13.709/18), o Marco Civil da Internet (Lei 12.965/14) (e o Regulamento da UE n. 2016/6790). Ainda, o documento poderá ser atualizado em decorrência de eventual atualização normativa, razão pela qual se convida o usuário a consultar periodicamente esta seção.

SEÇÃO 2 - COMO RECOLHEMOS OS DADOS PESSOAIS DO USUÁRIO E DO VISITANTE?

Os dados pessoais do usuário e visitante são recolhidos pela plataforma da seguinte forma:


Quando o usuário cria um perfil na plataforma Gefrot: esses dados são os dados de identificação básicos, como nome completo, CPF, telefone, e-mail, vencimento CNH e CNPJ da empresa em que trabalha.  A partir deles, podemos identificar o usuário, além de garantir uma maior segurança e bem-estar às suas necessidades. Ficam cientes os usuários de que seu perfil na plataforma estará acessível a todos usuários da transportadora, que contratou os serviços da Gefrot e se cadastraram via www.gefrot.com.

Quando o usuário preenche um check list ou abastecimento, poderá ser solicitado a localização atual do usuário e/ou uma foto. Ficam cientes os usuários que tanto a localização quanto as fotos deverão ser informados conforme solicitação da empresa contratante dos serviços da Gefrot.

Por intermédio de terceiro: a plataforma Gefrot recebe dados de terceiros, como CNPJ e razão social.


SEÇÃO 3 - QUAIS DADOS PESSOAIS RECOLHEMOS SOBRE O USUÁRIO E VISITANTE?

Os dados pessoais do usuário e visitante recolhidos são os seguintes:


Dados para a criação do perfil na plataforma Gefrot: nome completo, CPF, telefone, e-mail, vencimento CNH e CNPJ da empresa em que trabalha.

Newsletter: o e-mail cadastrado pelo visitante que optar por se inscrever na Newsletter será coletado e armazenado até que o usuário solicite o descadastro.

Dados relacionados a contratos: diante da formalização do contrato de compra e venda ou de prestação de serviços entre a plataforma e o usuário e visitante poderão ser coletados e armazenados dados relativos a execução contratual, inclusive as comunicações realizada entre a empresa e o usuário.


SEÇÃO 3 - PARA QUE FINALIDADES UTILIZAMOS OS DADOS PESSOAIS DO USUÁRIO E VISITANTE?

Os dados pessoais do usuário e do visitante coletados e armazenados pela plataforma Gefrot tem por finalidade:

Bem-estar do usuário e visitante: aprimorar o produto e/ou serviço oferecido, facilitar, agilizar e cumprir os compromissos estabelecidos entre o usuário e a empresa, melhorar a experiência dos usuários e fornecer funcionalidades específicas a depender das características básicas do usuário.

Melhorias da plataforma: compreender como o usuário utiliza os serviços da plataforma, para ajudar no desenvolvimento de negócios e técnicas.

Anúncios: apresentar anúncios personalizados para o usuário com base nos dados fornecidos.

Comercial: os dados são usados para personalizar o conteúdo oferecido e gerar subsídio à plataforma para a melhora da qualidade no funcionamento dos serviços.

Previsão do perfil do usuário: tratamento automatizados de dados pessoais para avaliar o uso na plataforma.

Dados de cadastro: para permitir o acesso do usuário a determinados conteúdo da plataforma, exclusivo para usuários cadastrados

Dados de contrato: conferir às partes segurança jurídica e facilitar a conclusão do negócio.

O tratamento de dados pessoais para finalidades não previstas nesta Política de Privacidade somente ocorrerá mediante comunicação prévia ao usuário, de modo que os direitos e obrigações aqui previstos permanecem aplicáveis.

SEÇÃO 4 - POR QUANTO TEMPO OS DADOS PESSOAIS FICAM ARMAZENADOS?

Os dados pessoais do usuário e visitante são armazenados pela plataforma durante o período necessário para a prestação do serviço ou o cumprimento das finalidades previstas no presente documento, conforme o disposto no inciso I do artigo 15 da Lei 13.709/18.

Os dados podem ser removidos ou anonimizados a pedido do usuário, excetuando os casos em que a lei oferecer outro tratamento.

Ainda, os dados pessoais dos usuários apenas podem ser conservados após o término de seu tratamento nas seguintes hipóteses previstas no artigo 16 da referida lei:

I - cumprimento de obrigação legal ou regulatória pelo controlador;

II - estudo por órgão de pesquisa, garantida, sempre que possível, a anonimização dos dados pessoais;

III - transferência a terceiro, desde que respeitados os requisitos de tratamento de dados dispostos nesta Lei;

IV - uso exclusivo do controlador, vedado seu acesso por terceiro, e desde que anonimizados os dados.

SEÇÃO 5 - SEGURANÇA DOS DADOS PESSOAIS ARMAZENADOS

A plataforma se compromete a aplicar as medidas técnicas e organizativas aptas a proteger os dados pessoais de acessos não autorizados e de situações de destruição, perda, alteração, comunicação ou difusão de tais dados.

Os dados relativas a cartões de crédito são criptografados usando a tecnologia "secure socket layer" (SSL) que garante a transmissão de dados de forma segura e confidencial, de modo que a transmissão dos dados entre o servidor e o usuário ocorre de maneira cifrada e encriptada.

A plataforma não se exime de responsabilidade por culpa exclusiva de terceiro, como em caso de ataque de hackers ou crackers, ou culpa exclusiva do usuário, como no caso em que ele mesmo transfere seus dados a terceiros. O site se compromete a comunicar o usuário em caso de alguma violação de segurança dos seus dados pessoais.

Os dados pessoais armazenados são tratados com confidencialidade, dentro dos limites legais. No entanto, podemos divulgar suas informações pessoais caso sejamos obrigados pela lei para fazê-lo ou se você violar nossos Termos de Serviço.

SEÇÃO 6 - COMPARTILHAMENTO DOS DADOS

O compartilhamento de dados do usuário ocorre apenas com os dados referentes a publicações realizadas pelo próprio usuário, tais ações são compartilhadas publicamente com os outros usuários.

Os dados do perfil do usuário são compartilhados publicamente em sistemas de busca e dentro da plataforma, sendo permitido ao usuário modificar tal configuração para que seu perfil não apareça nos resultados de busca de tais ferramentas.

SEÇÃO 6 - OS DADOS PESSOAIS ARMAZENADOS SERÃO TRANSFERIDOS A TERCEIROS?

Os dados pessoais serão compartilhados apenas com a empresa que o usuário estiver vinculado.

Os terceiros indicados recebem os dados na medida do necessário para permitir que eles realizem os serviços contratados.

Os fornecedores podem ser localizados ou possuir instalações localizadas em países diferentes. Nessas condições, os dados pessoais transferidos podem se sujeitar às leis de jurisdições nas quais o fornecedor de serviço ou suas instalações estão localizados.

Ao acessar nossos serviços e prover suas informações, você está consentindo o processamento, transferência e armazenamento desta informação em outros países.

Ao ser redirecionado para um aplicativo ou site de terceiros, você não será mais regido por essa Política de Privacidade ou pelos Termos de Serviço da nossa plataforma. Não somos responsáveis pelas práticas de privacidade de outros sites e lhe incentivamos a ler as declarações de privacidade deles.

SEÇÃO 07 – COOKIES OU DADOS DE NAVEGAÇÃO

Os cookies referem-se a arquivos de texto enviados pela plataforma ao computador do usuário e visitante e que nele ficam armazenados, com informações relacionadas à navegação no site. Tais informações são relacionadas aos dados de acesso como local e horário de acesso e são armazenadas pelo navegador do usuário e visitante para que o servidor da plataforma possa lê-las posteriormente a fim de personalizar os serviços da plataforma.

O usuário e o visitante da plataforma Gefrot  manifesta conhecer e aceitar que pode ser utilizado um sistema de coleta de dados de navegação mediante à utilização de cookies.

O cookie persistente permanece no disco rígido do usuário e visitante depois que o navegador é fechado e será usado pelo navegador em visitas subsequentes ao site. Os cookies persistentes podem ser removidos seguindo as instruções do seu navegador. Já o cookie de sessão é temporário e desaparece depois que o navegador é fechado. É possível redefinir seu navegador da web para recusar todos os cookies, porém alguns recursos da plataforma podem não funcionar corretamente se a capacidade de aceitar cookies estiver desabilitada.

SEÇÃO 8 - CONSENTIMENTO

Ao utilizar os serviços e fornecer as informações pessoais na plataforma, o usuário está consentindo com a presente Política de Privacidade.

O usuário, ao cadastrar-se, manifesta conhecer e pode exercitar seus direitos de cancelar seu cadastro, acessar e atualizar seus dados pessoais e garante a veracidade das informações por ele disponibilizadas.

O usuário tem direito de retirar o seu consentimento a qualquer tempo, para tanto deve entrar em contato através do e-mail cliente@gefrot.com ou por correio enviado ao seguinte endereço: Rua Joao Lunardelli, 2721, Cidade industrial, 81460-100, Curitiba-PR.

SEÇÃO 9 - ALTERAÇÕES PARA ESSA POLÍTICA DE PRIVACIDADE

Reservamos o direito de modificar essa Política de Privacidade a qualquer momento, então, é recomendável que o usuário e visitante revise-a com frequência.

As alterações e esclarecimentos vão surtir efeito imediatamente após sua publicação na plataforma. Quando realizadas alterações os usuários serão notificados. Ao utilizar o serviço ou fornecer informações pessoais após eventuais modificações, o usuário e visitante demonstra sua concordância com as novas normas.

Diante da fusão ou venda da plataforma à outra empresa os dados dos usuários podem ser transferidas para os novos proprietários para que a permanência dos serviços oferecidos.

SEÇÃO 10 – JURISDIÇÃO PARA RESOLUÇÃO DE CONFLITOS

Para a solução de controvérsias decorrentes do presente instrumento será aplicado integralmente o Direito brasileiro.

Os eventuais litígios deverão ser apresentados no foro da comarca em que se encontra a sede da empresa.


TERMOS E CONDIÇÕES GERAIS DE DO APLICATIVO GEFROT

Os serviços do Gefrot são fornecidos pela pessoa jurídica com a seguinte Razão Social: Gefrot, com nome fantasia Gefrot, titular da propriedade intelectual sobre software, website, aplicativos, conteúdos e demais ativos relacionados à plataforma Gefrot.


1. Do objeto

A plataforma visa licenciar o uso de seu software, website, aplicativos e demais ativos de propriedade intelectual, fornecendo ferramentas para auxiliar e dinamizar o dia a dia dos seus usuários.

A plataforma caracteriza-se pela prestação do seguinte serviço: gestão de abastecimentos e gestão de checklists.


2. Da aceitação

O presente Termo estabelece obrigações contratadas de livre e espontânea vontade, por tempo indeterminado, entre a plataforma e as pessoas físicas ou jurídicas, usuárias do site e aplicativo.

Ao utilizar a plataforma o usuário aceita integralmente as presentes normas e compromete-se a observá-las, sob o risco de aplicação das penalidades cabíveis.

A aceitação do presente instrumento é imprescindível para o acesso e para a utilização de quaisquer serviços fornecidos pela empresa. Caso não concorde com as disposições deste instrumento, o usuário não deve utilizá-los.


3. Do acesso dos usuários

Serão utilizadas todas as soluções técnicas à disposição do responsável pela plataforma para permitir o acesso ao serviço 24 (vinte e quatro) horas por dia, 7 (sete) dias por semana. No entanto, a navegação na plataforma ou em alguma de suas páginas poderá ser interrompida, limitada ou suspensa para atualizações, modificações ou qualquer ação necessária ao seu bom funcionamento.


4. Do cadastro

O acesso às funcionalidades da plataforma exigirá a realização de um cadastro prévio e, a depender dos serviços ou produtos escolhidos, o pagamento de determinado valor.

Ao se cadastrar o usuário deverá informar dados completos, recentes e válidos, sendo de sua exclusiva responsabilidade manter referidos dados atualizados, bem como o usuário se compromete com a veracidade dos dados fornecidos.

O usuário se compromete a não informar seus dados cadastrais e/ou de acesso à plataforma a terceiros, responsabilizando-se integralmente pelo uso que deles seja feito.

Mediante a realização do cadastro o usuário declara e garante expressamente ser plenamente capaz, podendo exercer e usufruir livremente dos serviços e produtos.

O usuário deverá fornecer um endereço de e-mail válido, através do qual o site realizará todas as comunicações necessárias.

Após a confirmação do cadastro, o usuário possuirá um login e uma senha pessoal, a qual assegura ao usuário o acesso individual à mesma. Desta forma, compete ao usuário exclusivamente a manutenção de referida senha de maneira confidencial e segura, evitando o acesso indevido às informações pessoais.

Toda e qualquer atividade realizada com o uso da senha será de responsabilidade do usuário, que deverá informar prontamente a plataforma em caso de uso indevido da respectiva senha.

Não será permitido ceder, vender, alugar ou transferir, de qualquer forma, a conta, que é pessoal e intransferível.

Caberá ao usuário assegurar que o seu equipamento seja compatível com as características técnicas que viabilize a utilização da plataforma e dos serviços ou produtos.

O usuário poderá, a qualquer tempo, requerer o cancelamento de seu cadastro junto ao site www.gefrot.com. O seu descadastramento será realizado o mais rapidamente possível, desde que não sejam verificados débitos em aberto.

O usuário, ao aceitar os Termos e Política de Privacidade, autoriza expressamente a plataforma a coletar, usar, armazenar, tratar, ceder ou utilizar as informações derivadas do uso dos serviços, do site e quaisquer plataformas, incluindo todas as informações preenchidas pelo usuário no momento em que realizar ou atualizar seu cadastro, além de outras expressamente descritas na Política de Privacidade que deverá ser autorizada pelo usuário.


5. Dos serviços ou produtos

A plataforma poderá disponibilizar para o usuário um conjunto específico de funcionalidades e ferramentas para otimizar o uso dos serviços e produtos.

Na plataforma os serviços ou produtos oferecidos estão descritos e apresentados com o maior grau de exatidão, contendo informações sobre suas características, qualidades, quantidades, composição, preço, garantia, prazos de validade e origem, entre outros dados, bem como sobre os riscos que apresentam à saúde e segurança do usuário.

Antes de finalizar a compra sobre determinado produto ou serviço, o usuário deverá se informar sobre as suas especificações e sobre a sua destinação.

6. Dos preços

A plataforma se reserva no direito de reajustar unilateralmente, a qualquer tempo, os valores dos serviços ou produtos sem consulta ou anuência prévia do usuário.

Os valores aplicados são aqueles que estão em vigor no momento do pedido.

Os preços são indicados em reais e não incluem as taxas de entrega, as quais são especificadas à parte e são informadas ao usuário antes da finalização do pedido.

Na contratação de determinado serviço ou produto, a plataforma poderá solicitar as informações financeiras do usuário, como CPF, endereço de cobrança e dados de cartões. Ao inserir referidos dados o usuário concorda que sejam cobrados, de acordo com a forma de pagamento que venha a ser escolhida, os preços então vigentes e informados quando da contratação. Referidos dados financeiros poderão ser armazenadas para facilitar acessos e contratações futuras.

A contratação dos serviços será renovada automaticamente pela plataforma, independentemente de comunicação ao usuário, mediante cobrança periódica da mesma forma de pagamento indicada pelo usuário quando da contratação do serviço.


7. Do cancelamento

O usuário poderá cancelar a contratação dos serviços de acordo com os termos que forem definidos no momento de sua contratação. Ainda, o usuário também poderá cancelar os serviços em até 7 (sete) dias após a contratação, mediante contato com o Gefrot, de acordo com o Código de Defesa do Consumidor (Lei no. 8.078/90).

O serviço poderá ser cancelado por:

a) parte do usuário: nessas condições os serviços somente cessarão quando concluído o ciclo vigente ao tempo do cancelamento;

b) violação dos Termos de Uso: os serviços serão cessados imediatamente.


9. Do suporte

Em caso de qualquer dúvida, sugestão ou problema com a utilização da plataforma, o usuário poderá entrar em contato com o suporte, através da própria plataforma www.gefrot.com, email cliente@gefrot.com OU telefone (41)99646-2337.

Estes serviços de atendimento ao usuário estarão disponíveis nos seguintes dias e horários: todos os dias 24 horas por dia.


10. Das responsabilidades

É de responsabilidade do usuário:

a) defeitos ou vícios técnicos originados no próprio sistema do usuário;

b) a correta utilização da plataforma, dos serviços ou produtos oferecidos, prezando pela boa convivência, pelo respeito e cordialidade entre os usuários;

c) pelo cumprimento e respeito ao conjunto de regras disposto nesse Termo de Condições Geral de Uso, na respectiva Política de Privacidade e na legislação nacional e internacional;

d) pela proteção aos dados de acesso à sua conta/perfil (login e senha).


É de responsabilidade da plataforma Gefrot.com.

a) indicar as características do serviço ou produto;

b) os defeitos e vícios encontrados no serviço ou produto oferecido desde que lhe tenha dado causa;

c) as informações que foram por ele divulgadas, sendo que os comentários ou informações divulgadas por usuários são de inteira responsabilidade dos próprios usuários;

d) os conteúdos ou atividades ilícitas praticadas através da sua plataforma.


A plataforma não se responsabiliza por links externos contidos em seu sistema que possam redirecionar o usuário à ambiente externo a sua rede.

Não poderão ser incluídos links externos ou páginas que sirvam para fins comerciais ou publicitários ou quaisquer informações ilícitas, violentas, polêmicas, pornográficas, xenofóbicas, discriminatórias ou ofensivas.


11. Dos direitos autorais

O presente Termo de Uso concede aos usuários uma licença não exclusiva, não transferível e não sublicenciável, para acessar e fazer uso da plataforma e dos serviços e produtos por ela disponibilizados.

A estrutura do site ou aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio, programas de computador, banco de dados, arquivos de transmissão e quaisquer outras informações e direitos de propriedade intelectual da razão social Gefrot, observados os termos da Lei da Propriedade Industrial (Lei nº 9.279/96), Lei de Direitos Autorais (Lei nº 9.610/98) e Lei do Software (Lei nº 9.609/98), estão devidamente reservados.

Este Termos de Uso não cede ou transfere ao usuário qualquer direito, de modo que o acesso não gera qualquer direito de propriedade intelectual ao usuário, exceto pela licença limitada ora concedida.

O uso da plataforma pelo usuário é pessoal, individual e intransferível, sendo vedado qualquer uso não autorizado, comercial ou não-comercial. Tais usos consistirão em violação dos direitos de propriedade intelectual da razão social Gefrot, puníveis nos termos da legislação aplicável.


12. Das sanções

Sem prejuízo das demais medidas legais cabíveis, a razão social Gefrot poderá, a qualquer momento, advertir, suspender ou cancelar a conta do usuário:

a) que violar qualquer dispositivo do presente Termo;

b) que descumprir os seus deveres de usuário;

c) que tiver qualquer comportamento fraudulento, doloso ou que ofenda a terceiros.


13. Da rescisão

A não observância das obrigações pactuadas neste Termo de Uso ou da legislação aplicável poderá, sem prévio aviso, ensejar a imediata rescisão unilateral por parte da razão social Gefrot e o bloqueio de todos os serviços prestados ao usuário.


14. Das alterações

Os itens descritos no presente instrumento poderão sofrer alterações, unilateralmente e a qualquer tempo, por parte de Gefrot, para adequar ou modificar os serviços, bem como para atender novas exigências legais. As alterações serão veiculadas OU pelo site www.gefrot.com OU pelo aplicativo Gefrot e o usuário poderá optar por aceitar o novo conteúdo ou por cancelar o uso dos serviços, caso seja assinante de algum serviço.


Os serviços oferecidos podem, a qualquer tempo e unilateralmente, e sem qualquer aviso prévio, ser deixados de fornecer, alterados em suas características, bem como restringido para o uso ou acesso.

15. Da política de privacidade


Além do presente Termo, o usuário deverá consentir com as disposições contidas na respectiva Política de Privacidade a ser apresentada a todos os interessados dentro da interface da plataforma.

16. Do foro


Para a solução de controvérsias decorrentes do presente instrumento será aplicado integralmente o Direito brasileiro.

Os eventuais litígios deverão ser apresentados no foro da comarca em que se encontra a sede da empresa.
"""),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
