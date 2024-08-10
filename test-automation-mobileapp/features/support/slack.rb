def send_slack_notif
  client = Slack::Web::Client.new
    client.auth_test

    if $failed > 0
      ENV['SLACK_REPORT']='yes'
    end

    if ENV['SLACK_REPORT']=='yes'
      files = client.files_upload(
            file: Faraday::UploadIO.new("features/support/reports/"+($report_format)+'.html', 'text/html'),
            title: ($report_format)+'.html',
            filename: ($report_format)+'.html',
        )
      client.chat_postMessage(
          channel: "#{ENV['SLACK_CHANNEL']}", 
          text: files["file"]["permalink"],
          blocks: slack_message,
          as_user: true
      )
    else
        client.chat_postMessage(
        channel: "#{ENV['SLACK_CHANNEL']}", 
        blocks: slack_message,
        as_user: true
        )
    end
end

def scenario_count(scenario)
  if scenario.status.to_s=="failed" || scenario.status.to_s=="undefined"
    if scenario.name != $scenario_name || $scenario_name == ""
      $failed += 1
      $scenario_count += 1
    end
elsif scenario.status.to_s=="passed"
    if scenario.name != $scenario_name || $scenario_name == ""
      $passed += 1
      $scenario_count += 1
    elsif scenario.name == $scenario_name 
      $failed -= 1
      $passed += 1
    end
end
$scenario_name = scenario.name

if scenario.feature.name != $feature_name || $feature_name == ""
  $feature_count += 1
end
$feature_name = scenario.feature.name

$percent_passed = ($passed.to_f / $scenario_count.to_f * 100).round
$percent_failed = ($failed.to_f / $scenario_count.to_f * 100).round
end

def chart_data
  chart = QuickChart.new(
    {
      type: 'doughnut',
      data: {
        datasets: [
          { 
            data: [$percent_passed, $percent_failed],
            backgroundColor: ['#009944','#D82C2C'],
            borderWidth: 0,
          }
        ],
      },
      options: {
        centerPercentage: 70,
        plugins: {
          datalabels: {
            display: false,
          },
          doughnutlabel: {
            labels: [
              {
                text: "#{$percent_passed}%",
                color: '#009944',
                font: {
                  size: 50,
                  weight: 'bold',
                },
              },
            ],
          },
        },
      },
    },
    background_color: '#00000000',
  )
end

def platform_detail
  if $tags_run.include? "@android"
      platform = "#{$caps_android[:deviceName]}, #{$caps_android[:platformName]} #{$caps_android[:platformVersion]}"
  elsif $tags_run.include? '@ios'
      platform = "#{$caps_ios[:deviceName]}, #{$caps_ios[:platformName]} #{$caps_ios[:platformVersion]}"
  else 
      platform = "#{$caps_android[:deviceName]}, #{$caps_android[:platformName]} #{$caps_android[:platformVersion]} & #{$caps_ios[:deviceName]}, #{$caps_ios[:platformName]} #{$caps_ios[:platformVersion]}"
  end
end

def slack_message
    messages = [
      {
        type: "header",
        text: {
          type: "plain_text",
          text: "AUTOMATION TEST RESULT (MOBILE APP) :jamtangan-com:",
          emoji: true
        }
      },
      {
        type: "section",
        text: {
          type: "mrkdwn",
          text: "*Overview:*\n>*Date:* `#{Time.now.strftime("%d %B %Y")}`\n>*App:* `#{get_config_data('APP_NAME')}`\n>*Environment:* `#{ENV['TARGET'].upcase}`\n>*Total Feature:* `#{$feature_count}`\n>*Total Scenario:* `#{$scenario_count}`\n>*Success:* `#{$passed} (#{$percent_passed}%)` :white_check_mark:\n>*Failed:* `#{$failed} (#{$percent_failed}%)` :x:"
        },
        accessory: {
          type: "image",
          image_url: "#{chart_data.get_short_url}",
          alt_text: "Success: #{$passed} (#{$percent_passed}%), Failed: #{$failed} (#{$percent_failed}%)"
        }
      },
      {
        type: "section",
        text: {
          type: "mrkdwn",
          text: "You can click button below or download the attachment html file to see more detail, cc: @qa-uf-jt",
        },
      },
      {
        type: "actions",
        elements: [
          {
            type: "button",
            text: {
              type: "plain_text",
              text: "View Detail Report",
              emoji: true
            },
            style: "primary",
            url: "https://qa-reports.ctlyst.id/uf-jamtangan-app/#{Time.at($start_time).strftime("%Y%m%d")}/"+($report_format)+'.html',
            action_id: "button-action"
          }
        ]
      }
    ]
end