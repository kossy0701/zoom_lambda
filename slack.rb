class Slack

  def initialize(join_url, daily_person)
    @join_url = join_url
    @daily_person = daily_person
  end

  def notify
    uri = URI.parse(ENV['WEBHOOK_URL'])

    Net::HTTP.post_form(uri, { payload: payload })
  end

  private

    def payload
      {
        username: "デイリーお知らせbot",
        icon_emoji: ":spiral_calendar_pad",
        channel: "#general",
        text: prepare_text
      }.to_json
    end

    def prepare_text
      <<-EOS
        <!here> 会議が始まります。
        担当者：#{@daily_person}
        Zoom会議には以下URLで入れます。
        #{@join_url}
      EOS
    end
end
