:- module(
       funcionario,
       [
        carrega_tab/1,
        funcionario/9,
        insere/9,
        remove/1,
        atualiza/9,
        sincroniza/0
       ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent
    funcionario(funCod: positive_integer,
            funNome:string,
           funCpf:string,
           funLgr: string,
           funSexo: string,
           funCid: string,
           funEst: string,
           funFon: string,
           funEmail: string).

%:- initialization(db_attach('tbl_funcionario.pl',[])).
:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic funcionario/9.

insere(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail):-
    chave:pk(funcionario, FunCod),
    with_mutex(funcionario,
    assert_funcionario(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)).

remove(FunCod):-
    with_mutex(funcionario,
      retract_funcionario(FunCod,_FunNome,_FunCpf,_FunLgr,_FunSexo,_FunCid,_FunEst,_FunFon,_FunEmail)).

atualiza(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail):-
    with_mutex(funcionario,
              (retractall_funcionario(FunCod,_FunNome,_FunCpf,_FunLgr,_FunSexo,_FunCid,_FunEst,_FunFon,_FunEmail),
                assert_funcionario(FunCod,FunNome,FunCpf,FunLgr,FunSexo,FunCid,FunEst,FunFon,FunEmail)
              )
               ).

sincroniza :-
    db_sync(gc(always)).


