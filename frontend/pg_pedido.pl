/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).



/* PÃ¡gina de cadastro de bookmark */
cadastroPedido(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Pedidos')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Novo Pedidos'),
                \form_bookmarkpedido
              ]) ]).

form_bookmarkpedido -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/pedidos' )"),
                action('/api/v1/api_pedido/')],
              [ \metodo_de_envio('POST'),
                \campo(emiObsCod, 'Cod. Obs.', text),
                \campo(emiObs, 'Observa��o', text),
                \campo(emiDatObs, 'Data', text),
                \campo(emiUsuCod, 'Usu�rio', text),
                \enviar_ou_cancelar('/pedidos')
              ])).

/*
enviar_ou_cancelar(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).




campo(Nome, Titulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).


*/
/* PÃ¡gina para ediÃ§Ã£o (alteraÃ§Ã£o) de um bookmark  */

editarPedido(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( pedido:pedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    ->
    reply_html_page(
        boot5rest,
        [ title('Pedidos')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Pedidos'),
                \form_bookmarkpedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkpedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/pedidos' )"),
                action('/api/v1/api_pedido/~w' - Id)],

              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(emiObsCod, 'Cod. Obs', text, EmiObsCod),
                \campo(emiObs, 'Observa��o', text, EmiObs),
                \campo(emiDatObs, 'Data', text, EmiDatObs),
                \campo(emiUsuCod, 'Usu�rio', text, EmiUsuCod),
                \enviar_ou_cancelar('/pedidos')
              ])).


mostraPedido(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( pedido:pedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    ->
    reply_html_page(
        boot5rest,
        [ title('Pedidos')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Meus Pedidos'),
                \form_bookmarkmospedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_bookmarkmospedido(Id,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod) -->
    html(form([ id('bookmark-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/api_pedido/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo_nao_editavel(emiObsCod, 'Cod. Obs', text, EmiObsCod),
                \campo_nao_editavel(emiObs, 'Observa��o', text, EmiObs),
          \campo_nao_editavel(emiDatObs, 'Data', text, EmiDatObs),
             \campo_nao_editavel(emiUsuCod, 'Usu�rio', integer, EmiUsuCod),
                \enviar_ou_cancelar('/pedidos')
              ])).
/*
campo(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome), value(Valor)])
             ] )).

campo_nao_editavel(Nome, Titulo, Tipo, Valor) -->
    html(div(class('mb-3 w-25'),
             [ label([ for(Nome), class('form-label')], Titulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome),
                       % name(Nome),%  nÃ£o Ã© para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).
*/
