require 'rails_helper'


RSpec.describe V2::ArticlesController do
  describe 'GET #show' do
    def trigger
      get :show, params: { id: article.id }
    end

    let(:article) { Article.create(title: 'Hello World') }

    it 'returns http success' do
      trigger
      expect(response).to have_http_status(:success)
    end

    it 'respond body JSON with attributes' do
      trigger
      expect(response.body).to look_like_json
      expect(body_as_json).to be_kind_of(Hash)
    end

    it 'correct article attributes are rendered' do
      # we are not stubbing we will just make sure the Serializer is called
      expect_any_instance_of(ArticleSerializer)
        .to receive(:as_json)
        .and_call_original # this will ensure the return value
                           # is called as it would normaly do

        trigger

        article_id = body_as_json
          .fetch(:article)
          .fetch(:id)
          .to_i

        expect(article.id).to eq article.id
    end
  end
end