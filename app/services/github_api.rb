class GithubApi

  def initialize
    @github_api = Faraday.new(
      url: 'https://api.github.com/',
      headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ENV.fetch("GITHUB_ACCESS_TOKEN")}", "X-GitHub-Api-Version" => "2022-11-28"}
    )
  end

  def invite_user(user)
    response = @github_api.post('orgs/ORG/invitations') do |req|
      req.params['org'] = 'mistral-aie'
      req.body = {
        "email" => "#{user.email}",
        "role" => "direct_member",
        "team_ids" =>  [12548001]}
        .to_json
    end
  end

  def remove_user
    response = @github_api.delete('orgs/mistral-aie/members/romain-decline')
  end

end
