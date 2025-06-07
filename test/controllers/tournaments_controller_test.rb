require "test_helper"

class TournamentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tournament = tournaments(:one)
  end

  test "should get index" do
    get tournaments_url, as: :json
    assert_response :success
  end

  test "should create tournament" do
    assert_difference("Tournament.count") do
      post tournaments_url,
           params: {
             tournament: {
               date: @tournament.date,
               name: @tournament.name,
               prizepool: @tournament.prizepool,
               winner_id: @tournament.winner_id
             }
           }, as: :json
    end

    assert_response :created
  end

  test "should show tournament" do
    get tournament_url(@tournament), as: :json
    assert_response :success
  end

  test "should update tournament" do
    patch tournament_url(@tournament),
          params: {
            tournament: {
              date: @tournament.date,
              name: @tournament.name,
              prizepool: @tournament.prizepool,
              winner_id: @tournament.winner_id
            }
          }, as: :json
    assert_response :success
  end

  test "should destroy tournament" do
    assert_difference("Tournament.count", -1) do
      delete tournament_url(@tournament), as: :json
    end

    assert_response :no_content
  end
end
