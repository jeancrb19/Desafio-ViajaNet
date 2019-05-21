Dado("que estou no site da ViajaNet") do
  visit('https://www.viajanet.com.br/')
end

Dado("realizo uma pesquisa de Aereo {string}") do |destino|
  within(EL['modal_inicial']) do
    find(EL['btn_fechar_modal']).click 
  end
  @methods.send("preenche_destino_#{destino}")
  @methods.preenche_data
  @methods.pesquisar
end

Quando("insiro os dados do passageiro e pagamento") do
    @methods.preencher_checkout
end

Entao("confirmo que a reserva está em processamento") do
  assert_no_selector('.loader-container.ng-scope', wait: 15)
  assert_text('Reserva em processamento.')
end