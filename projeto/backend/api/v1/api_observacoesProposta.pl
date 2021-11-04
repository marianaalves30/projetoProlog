:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_json)).

:- use_module(bd(observacoesProposta),[]).

api_observacoesProposta(get,'',_Pedido):- !,
    envia_tabelaobs.

api_observacoesProposta(get,AtomId,_Pedido):-
    atom_number(AtomId,Id),
    !,
    envia_tuplaobs(Id).

api_observacoesProposta(post,_,Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tuplaobs(Dados).

api_observacoesProposta(put,AtomId,Pedido):-
    atom_number(AtomId,Id),
    http_read_json_dict(Pedido,Dados),!,
    atualiza_tuplaobs(Dados,Id).

api_observacoesProposta(delete,AtomId,_Pedido):-
    atom_number(AtomId,Id),!,
    observacoesProposta:remove(Id),
    throw(http_reply(no_content)).

api_observacoesProposta(Met,Id,_Pedido):-
    throw(http_reply(method_not_allowed(Met,Id))).

insere_tuplaobs(_{emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod}):-
    observacoesProposta:insere(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> envia_tuplaobs(EmiCod)
    ; throw(http_reply(bad_request('Informação Ausente'))).

atualiza_tuplaobs(_{emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod},EmiCod):-
    observacoesProposta:atualiza(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> envia_tuplaobs(EmiCod)
    ;  throw(http_reply(not_found(EmiCod))).

envia_tuplaobs(EmiCod):-
observacoesProposta:observacoesProposta(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod)
    -> reply_json_dict(_{emiCod:EmiCod, emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod})
    ; throw(http_reply(not_found(EmiCod))).

envia_tabelaobs:-
    findall(_{emiCod:EmiCod, emiObsCod: EmiObsCod, emiObs:EmiObs, emiDatObs: EmiDatObs,emiUsuCod: EmiUsuCod},
observacoesProposta:observacoesProposta(EmiCod,EmiObsCod,EmiObs,EmiDatObs,EmiUsuCod),
            Tuplas),
    reply_json_dict(Tuplas).


