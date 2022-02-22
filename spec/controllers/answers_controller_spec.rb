# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect do
          post :create,
               params: { answer: attributes_for(:answer), question_id: question, format: :js }
        end.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create,
               params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js }
        end.to_not change(question.answers, :count)
      end

      it 're-renders question show view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, user: user) }

    describe 'Author' do
      before { login(user) }

      it 'deletes his answer' do
        expect { delete :destroy, params: { id: answer, question_id: question } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to show' do
        delete :destroy, params: { id: answer, question_id: question }
        expect(response).to redirect_to question_path(question)
      end
    end

    describe 'User' do
      it 'do not deletes anothers answers' do
        expect { delete :destroy, params: { id: answer, question_id: question } }.not_to change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    describe 'Author' do
      before { login(user) }

      let!(:answer) { create(:answer, question: question, user: user) }

      context 'with valid attributes' do
        it 'changes answer attributes' do
          patch :update, params: { id: answer, answer: {body: 'new body' } }, format: :js
          answer.reload
          expect(answer.body).to eq 'new body'
        end

        it 'renders update view' do
          patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        it 'does not change answer attributes' do
          expect do
            patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
          end.to_not change(answer, :body)
        end

        it 'renders update view' do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
          expect(response).to render_template :update
        end
      end
    end
  end
end
