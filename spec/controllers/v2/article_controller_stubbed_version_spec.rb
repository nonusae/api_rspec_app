require 'rails_helper'

RSpec.describe V2::ArticlesController do
  describe 'GET #show' do
    def trigger
      get :show, params: { id: article.id }
    end

    let(:article) { Article.create(title: 'Hello World') }

    it 'return http success' do
      trigger
      expect(response).to have_http_status(:success)
    end

    context 'upon call' do
      before do
        serializer_double =  instance_double(ArticleSerializer)

        expect(ArticleSerializer)
          .to receive(:new)
          .and_return(serializer_double)

        expect(serializer_double)
          .to receive(:as_json)
          .and_return( {article: 'stubbed hash by ArticleSerializer'} )

        trigger
      end

      it 'uses ArticleSerializer to render body JSON' do
        expect(body_as_json).to match({ article: 'stubbed hash by ArticleSerializer'})
      end
    end
  end
end