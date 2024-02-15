require 'rails_helper'

RSpec.describe "Events", type: :request do
  

  # get events - index
  describe "GET /events" do
    let(:user) {create(:user)}
  let(:token) {auth_token_for_users(user)}

    it 'returns a response with all the events' do
      create(:event)
      get '/events', headers: {Authorization: "Bearer #{token}"}
      expect(response.body).to eq(Event.all.to_json)
    end
  end

  # get event - show
  describe "GET /event" do
    let(:event) {create(:event)}
    let(:user) {create(:user)}
    let(:token) {auth_token_for_users(user)}

    it 'requires a response with the specified event' do
      get "/events/#{event.id}", headers: {Authorization: "Bearer #{token}"}
      expect(response.body).to eq(event.to_json)
    end
  end

  # create events - create
  describe "POST /events" do
    let(:user) {create(:user)}
    let(:sport) {create(:sport)}
    let(:token) {auth_token_for_users(user)}

    before do
      event_attributes = attributes_for(:event, sport_ids: [sport.id])
      post "/events", params: event_attributes, headers: {Authorization: "Bearer #{token}"}
    end

    it 'creates a new event' do
      expect(Event.count).to eq(1)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  # update events - update
  describe "PUT /events/:id" do
    let(:event) {create(:event)}
    let(:user) {create(:user)}
  let(:token) {auth_token_for_users(user)}

    before do
      put "/events/#{event.id}", params: { title: "New Title" }, headers: {Authorization: "Bearer #{token}"}
    end

    it 'updates an event' do
      event.reload
      expect(event.title).to eq("New Title")
    end
  end

  # delete event - destroy
  describe "DELETE /events/:id" do
    let(:event) {create(:event)}
    let(:user) {create(:user)}
    let(:token) {auth_token_for_users(user)}
    
    before do
      delete "/events/#{event.id}", headers: {Authorization: "Bearer #{token}"}
    end

    it 'deletes an event' do
      expect(Event.count).to eq(0)
    end
  end
end