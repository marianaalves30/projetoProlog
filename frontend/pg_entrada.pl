/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(bookmark), []).

entrada(_):-
    reply_html_page(
        boot5rest,
        [ title('SI aplicado a industria de Moveis')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
                \html_requires(js('bookmark.js')),
                \line,
                \titulo_da_pagina('SI Aplicado a Industria de Moveis '),
                \line,
                \corpo_pag


              ]) ]).

titulo_da_pagina(Titulo) -->
    html( div(class('text-center align-items-center w-100'),
              h1('display-3', Titulo))).

tabela_de_bookmarksEntrada -->
    html(div(class('container-fluid py-3'),
             [ \line,
               \cabeca_da_tabela(' ', '/alunos','Alunos'),
               \cabeca_da_tabela('Funcion�rio', '/funcionarios','Funcion�rios'),
               \cabeca_da_tabela('Pessoa', '/pessoas','Pessoas'),
               \cabeca_da_tabela('Bairro', '/bairros','Bairros'),
               \cabeca_da_tabela('Estado', '/estados','Estados'),
               \cabeca_da_tabela('Compra', '/compras','Compras'),
               \cabeca_da_tabela('Pedido', '/pedidos','Pedidos'),
               \cabeca_da_tabela('Proposta', '/propostas','Propostas'),
               \cabeca_da_tabela('ObsProposta', '/observacoesPropostas','ObsPropostas')

             ]
            )).

corpo_pag -->
    html(main(class('py-5'),
              section(class('container login py-5'),
                      div(class('row g-0'),
                          [div(class('col-lg-7'),
                               img([ class('img-fluid'),
                                     alt('Era pra ter uma imagem aqui'),
                                     src('img/moveis.png')],[])),
                           div(class('col-lg-5 text-center py-5'),
                               [
                                   h1('Tabelas'),

                                 \tabela_de_bookmarksEntrada

                               ])])))
        ).

cabeca_da_tabela(Titulo,Link,Nome) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      Nome))
              ]) ).

line -->
    html(p(hr([size = 1]))).
/*
tabela -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalho,
                     tbody(\corpo_tabela)
                   ]))).

cabecalho -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'Titulo'),
                    th([scope(col)], 'URL'),
                    th([scope(col)], 'Acoes')
                  ]))).



corpo_tabela -->
    {
        findall( tr([th(scope(row), Id), td(Titulo), td(Link), td(Acoes)]),
                 linha(Id, Titulo, Link, Acoes),
                 Linhas )
    },
    html(Linhas).




linha(IDo,Titulo, Link, Acoes):-
    bookmark:bookmark(IDo,Titulo,Link),
    acoes(IDo,Acoes),
    Link = a([href(URL)], URL).


acoes(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/bookmark/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/api_bookmark/~w' - Id),
                  onClick("apagar( event, '/' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

*/
% Ícones do Bootstrap 5

lapis -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-pencil'),
               viewBox('0 0 16 16')
             ],
             path(d(['M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0',
             ' 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5',
             ' 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4',
             ' 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761',
             ' 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5',
             ' 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z']),
                  []))).

lixeira -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-trash'),
               viewBox('0 0 16 16')
             ],
             [ path(d(['M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1',
                       ' .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5',
                       ' 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z']),
                    []),
               path(['fill-rule'(evenodd),
                     d(['M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0',
                        ' 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1',
                        ' 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4',
                        ' 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882',
                        ' 4H4.118zM2.5 3V2h11v1h-11z'])],
                    [])])).

