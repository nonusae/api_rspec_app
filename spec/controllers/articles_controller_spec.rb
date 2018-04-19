require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #show" do

    before do
      get :show, params: {id: article.id}
    end

    let(:article) { Article.create(title: 'Hello World' ) }


    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing expected Article attributes" do
      expect(response.body).to look_like_json
      expect(body_as_json.keys).to match_array(['id', 'title'])
      expect(body_as_json).to match({
        id: article.id,
        title: 'Hello World'
      })

    end
  end

end
