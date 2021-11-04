/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(funcionario), []).

entradaFuncionario(_):-
    reply_html_page(
        boot5rest,
        [ title('Funcionarios')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
                \html_requires(js('bookmark.js')),
                \titulo_da_paginaFun('Funcionarios '),
                \tabela_de_bookmarksFun

              ]) ]).

titulo_da_paginaFun(Titulo) -->
    html( div(class('text-center align-items-center w-100'),
              h1('display-3', Titulo))).

tabela_de_bookmarksFun -->
    html(div(class('container-fluid py-3'),
             [
               \cabeca_da_tabelaFun('     ', '/','voltar'),
               \cabeca_da_tabelaFun('Funcionarios', '/funcionario','Novo Funcionario'),
               \tabelafun
             ]
            )).


cabeca_da_tabelaFun(Titulo,Link,Nome) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      Nome))
              ]) ).


tabelafun -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalhofun,
                     tbody(\corpo_tabelafun)
                   ]))).

cabecalhofun -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'Nome'),
                    th([scope(col)], 'CPF'),
                    th([scope(col)], 'Email'),
                    th([scope(col)], 'Acoes')
                  ]))).



corpo_tabelafun -->
    {
        findall( tr([th(scope(row), Id), td(Nome), td(Cpf),td(Email),td(Acoes)]),
                 linhafun(Id, Nome, Cpf,Email, Acoes),
                 Linhas )
    },
    html(Linhas).




linhafun(Id,Nome, Cpf,Email, Acoes):-
    funcionario:funcionario(Id,Nome,_,_,_,_,_,Cpf,Email),
    acoesfun(Id,Acoes).


acoesfun(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/funcionario/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/api_funcionario/~w' - Id),
                  onClick("apagar( event, '/funcionarios' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].
