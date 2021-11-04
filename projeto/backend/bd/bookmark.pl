:- module(
       bookmark,
       [ carrega_tab/1,
         bookmark/3,
         insere/3,
         remove/1,
         atualiza/3 ]).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- dynamic bookmark/3.

:- persistent
   bookmark( id:positive_integer, % chave primária
             titulo:string,
             url:string ).


:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).


insere(Id, Ttulo, URL):-
    chave:pk(bookmark, Id),
    with_mutex(bookmark,
               assert_bookmark(Id, Ttulo, URL)).

remove(Id):-
    with_mutex(bookmark,
               retractall_bookmark(Id, _Ttulo, _URL)).


atualiza(Id, Ttulo, URL):-
    with_mutex(bookmark,
               ( retract_bookmark(Id, _TtAntigo, _URLAntiga),
                 assert_bookmark(Id, Ttulo, URL)) ).



