require 'nokogiri'

def merge_html_reports(report_files, output_file)
  merged_report = nil

  report_files.each do |file|
    report = Nokogiri::HTML(File.read(file))
    if merged_report.nil?
      merged_report = report
    else
      report.css('body > *').each do |node|
        merged_report.css('body').first.add_child(node)
      end
    end
  end

  File.write(output_file, merged_report.to_html)
end

report_files = Dir.glob('report_*.html')
merge_html_reports(report_files, 'merged_report.html')
