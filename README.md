# SEU

O SEU foi desenvolvido no meu trabalho de conclusão de curso (Sistemas de Informação) e é um sistema para gestão de certificados de eventos que conta com recursos como a validação de certificados, emissão em formato PDF, cadastro de eventos, personalização de certificados e futuramente permitirá a inscrição dos usuários nestes eventos.

## Requisitos e instalação 

Para executar o sistema localmente é necessário ter acesso disponível alguma conexão a algum banco de dados postgres e ter instalado na máquina a aplicação [WKHTMLTOPDF](https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF).

Se você tiver preferir pode rodar a aplicação utilizando o doker compose, já que na raiz do projeto há os arquivos necessários e configurados para tal.

## Webpack
O sistema utiliza o webpack para trabalhar com assets, logos arquivos como fonts, javascript e CSS ficam na pasta app/javascript. Arquivos de imagems continuam na pasta assets. Você pode entender mais sobre o webpack com rails neste [link](https://github.com/rails/webpacker).

## Link úteis

* [https://www.postgresql.org/](https://www.postgresql.org/)
* [https://guides.rubyonrails.org/](https://guides.rubyonrails.org/)
* [https://github.com/rails/webpacker](https://github.com/rails/webpacker)
* [https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF](https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF)
* [https://github.com/docker/compose](https://github.com/docker/compose)
