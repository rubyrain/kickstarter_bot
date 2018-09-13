require 'net/http'
require 'nokogiri'
require 'dotenv/load'
require 'slack-ruby-bot'

$slack_token = ENV["SLACK_TOKEN"]
$slack_channel = "#general"
$go_url = "https://www.kickstarter.com/projects/dazz3dprinter/dazz-3d-the-most-advanced-lcd-sla-3d-printer?ref=user_menu"
$reward_id = 6805561

Slack.configure do |config|
    config.token = $slack_token
end
 


$client = Slack::Web::Client.new 
def process_response(response,reward_id)
    latest_url = nil
    if response.code == 502
        return false
    else
        page = Nokogiri::HTML(response.body) 
        li = page.search('li').at("li[data-reward-id=#{reward_id}]").search('span').text
        status = li.split("\n")[3]
        if status == "Reward no longer available"
            return "Current Status - #{status}" 
        else
            p "[Info] Sent to slack."
            $client.chat_postMessage(channel: $slack_channel, text:  "현재 상태 : #{status}, #{$go_url}", as_user: true)
            return "Current Status - #{status}"
        end
        
    end
end

def get_response(url,reward_id)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri

        response = http.request request # Net::HTTPResponse object
        return process_response(response,reward_id) # return URL
    end
end

def main() 
    while true
        p get_response("https://www.kickstarter.com/projects/dazz3dprinter/dazz-3d-the-most-advanced-lcd-sla-3d-printer?ref=user_menu", $reward_id )
        sleep 2
    end
end


main()

