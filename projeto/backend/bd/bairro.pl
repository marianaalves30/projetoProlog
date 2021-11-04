:- module(
       bairro,
       [
       carrega_tab/1,
       bairro/5,
       insere/5,
       remove/1,
       atualiza/5,
       sincroniza/0
       ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
    bairro(baiCod: positive_integer,
           baiNom: string,
           baiCep: string,
           baiNomAbre: string,
           baiQtd:string
          ).

%:- initialization(db_attach('tbl_bairro.pl',[])).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic bairro/5.

insere(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd):-
    chave:pk(bairro, BaiCod),
    with_mutex(bairro,
    assert_bairro(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd)).

remove(BaiCod):-
    with_mutex(bairro,
      retract_bairro(BaiCod,_BaiNom,_BaiCep,_BaiNomAbre,_BaiQtd)).

atualiza(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd):-
    with_mutex(bairro,
               (retractall_bairro(BaiCod,_BaiNom,_BaiCep,_BaiNomAbre,_BaiQtd),
                assert_bairro(BaiCod,BaiNom,BaiCep,BaiNomAbre,BaiQtd))).

sincroniza :-
    db_sync(gc(always)).

