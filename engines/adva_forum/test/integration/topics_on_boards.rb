require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper' ))

class TopicsOnBoards < ActionController::IntegrationTest
  def setup
    factory_scenario  :site_with_forum
    login_as          :admin
    @board          = Factory :board, :site => @site, :section => @forum
    @another_board  = Factory :board, :title => 'another board', :site => @site, :section => @forum
    @topic          = @forum.topics.post(@user, Factory.attributes_for(:topic, :section => @forum))
    @topic.save
  end
  
  def test_an_admin_creates_a_new_topic
     # Go to section
    get forum_path(@forum)
    
    # Admin clicks link to go to the board
    click_link @board.title
    
    # Admin clicks link to create a new topic
    click_link 'Post one now'
    assert Topic.count == 0
    
    assert_template 'topics/new'
    
    fill_in       'Title',       :with => 'Test topic'
    fill_in       'Body',        :with => 'Test topic description'
    click_button  'Post topic'
    
    assert Topic.count == 1
    assert Topic.first.board == @board
    assert_template 'topics/show'
  end
  
  def test_an_admin_moves_an_existing_topic_to_another_board
     # Go to section
    get forum_path(@forum)
    
    # Admin clicks link to go to the board
    click_link @board.title
    
    # Admin clicks link to show topic
    click_link @topic.title
    
    # Admin clicks link to edit topic
    click_link 'Edit'
    
    assert_template 'topics/edit'
    
    select  @another_board
    click_button  'Save topic'
    
    @topic.reload
    assert @topic.board == @another_board
    assert_template 'topics/show'
  end
end
