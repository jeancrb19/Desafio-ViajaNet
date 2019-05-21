Before do
    @methods = Methods.new
end

After do |scn|
    file_name = scn.name.gsub(' ', '_').downcase!
    target = "data/screenshots/#{file_name}.png"
    if scn.failed?
      page.save_screenshot(target)
      embed(target, 'image/png', 'Evidência')
    else
      page.save_screenshot(target)
      embed(target, 'image/png', 'Evidência')
    end
    page.driver.quit
end

at_exit do
    ReportBuilder.configure do |config|
        config.input_path = 'data/report/report.json'
        config.report_path = 'data/report/viaja_net_report'
        config.report_types = [:retry, :html]
        config.report_title = 'Teste ViajaNet'
        config.include_images = true
        config.color = 'blueo'
        config.additional_info = {Ambiente: "https://www.viajanet.com.br/", Destino: "#{$destino_nac}"}
      end
      ReportBuilder.build_report  
end