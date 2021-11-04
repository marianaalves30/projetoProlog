
:- module(
    pessoa,
    [
        carrega_tab/1,
        pessoa/20,
        insere/20,
        remove/1,
        atualiza/20,
        sincroniza/0
    ]).


% Importa a biblioteca persistency
:- use_module(library(persistency)).

% Esquema da relação Sgit001
:- persistent
pessoa(
              fisCod: positive_integer,
              fisTipo:  string,
              fisNom: string,
              fisRazSoc: string,
              fisDatNas: string,
              fisSexo: string,
              fisCpf: string,
              fisCnpj: string,
              fisEstNom: string,
              fisCidNom: string,
              fisBaiNom: string,
              fisLgrNom: string,
              fisLgrNro: string,
              fisEmail: string,
              fisFon: string,
              fisFon2: string,
              fisFax: string,
              fisCel: string,
              fisDatReg: string,
              fidIndCad: string).

%:- initialization((db_attach('tbl_pessoa.pl',[]),
%               at_halt(db_sync(gc(always))) )).
:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

:- dynamic pessoa/20.

insere(FisCod,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad):-
    chave:pk(bairro, FisCod),
    with_mutex(pessoa,
    assert_pessoa(FisCod,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad)).

remove(FisCod):-
    with_mutex(pessoa,
      retractall_pessoa(FisCod,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).

atualiza(FisCod,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad):-
    with_mutex(pessoa,
               (retractall_pessoa(FisCod,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),
                assert_pessoa(FisCod,FisTipo,FisNom,FisRazSoc,FisDatNas,FisSexo,FisCpf,FisCnpj,FisEstNom,FisCidNom,FisBaiNom,FisLgrNom,FisLgrNro,FisEmail,FisFon,FisFon2,FisFax,FisCel,FisDatReg,FidIndCad))).

sincroniza :-
    db_sync(gc(always)).

