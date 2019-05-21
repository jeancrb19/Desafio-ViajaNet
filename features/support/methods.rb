class Methods
    
    def preenche_destino_nacional
        $destino_nac = Destination['nacional'].sample
        find(EL['campo_destino']).set($destino_nac)
        find(EL['campo_destino']).send_keys(:enter) if has_selector?(EL['lista_destinos'], visible: true)
    end

    def preenche_destino_internacional
        $destino_inter = Destination['internacional'].sample
        find(EL['campo_destino']).set($destino_inter)
    end

    def preenche_data
        find(EL['data_ida']).click
        dt_ida = Time.now + 86400*5
        dt_ida = dt_ida.strftime('%d')
        first('td', text: dt_ida).click
        # binding.pry
        # find(EL['data_volta']).click
        dt_volta = Time.now + 86400*20
        dt_volta = dt_volta.strftime('%d')
        all('td', text: dt_volta)[1].click
    end

    def pesquisar
        find(EL['btn_pesquisar']).click
        assert_selector(EL['btn_comprar'], wait: 60)
        first(EL['btn_comprar']).click
        find('.md-close').click if has_selector?('.md-content')
    end

    def foco_browser
        result = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(result)
        sleep 1
      end

    def preencher_checkout
        Methods.new.foco_browser
        assert_no_selector('.loader-container.ng-scope', wait: 15)
        dados = CADASTRO[:dados_validos]
        email = dados[:email]
        find(EL['campo_email_contato']).set(email)
        find(EL['campo_nome']).set(dados[:nome])
        find(EL['campo_sobrenome']).set(dados[:sobrenome])
        sleep 1
        find(EL['campo_dt_nasc']).set('01/01/1990')
        within('#passengers_form') do
            find('select').select('Masculino')
        end
        find(EL['cartao_bandeira']).select('Mastercard')
        find(EL['cartao_numero']).set('5102 0677 0024 0174')
        find(EL['cartao_mes']).select('11')
        find(EL['cartao_ano']).select('2025')
        find(EL['cartao_cpf']).set(dados[:cpf])
        find(EL['cartao_cvv']).set('225')
        find(EL['cartao_nome']).set(dados[:nome])
        find(EL['campo_cep']).set('03980080')
        find(EL['campo_num_casa']).set('115')
        find(EL['campo_email']).set(email)
        find(EL['campo_confirma_email']).set(email)
        find(EL['campo_telefone']).set(dados[:telefone])
        find(EL['check_termos']).click
        find(EL['btn_finalizar']).click
    end
end