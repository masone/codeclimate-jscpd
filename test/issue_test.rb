require 'minitest_helper'
require 'json'

require 'cc/engine/jscpd/issue'

module CC
  module Engine
    module Jscpd
      class IssueTest < Minitest::Test
        describe 'Issue' do
          let(:issue) { Issue.new(path: 'path', other_path: 'path2', start: 5, other_start: 7, lines: 10) }

          describe 'to_json' do
            let(:issue_json) { JSON.parse(issue.to_json) }

            it 'returns json' do
              assert_instance_of Hash, issue_json
            end
            it 'has type issue' do
              assert_equal 'issue', issue_json['type']
            end
            it 'has a check_name' do
              refute_nil issue_json['check_name']
            end
            it 'has a description' do
              refute_nil issue_json['description']
            end
            it 'has a content' do
              refute_nil issue_json['content']
            end
            it 'has category Complexity' do
              assert_equal ['Duplication'], issue_json['categories']
            end

            describe 'location' do
              it 'sets path' do
                assert_equal 'path', issue_json['location']['path']
              end
              it 'sets lines.begin' do
                assert_equal 5, issue_json['location']['lines']['begin']
              end
              it 'sets lines.end' do
                assert_equal 15, issue_json['location']['lines']['end']
              end
            end

            describe 'other_locations' do
              it 'sets path' do
                assert_equal 'path2', issue_json['other_locations'].first['path']
              end
              it 'sets lines.begin' do
                assert_equal 7, issue_json['other_locations'].first['lines']['begin']
              end
              it 'sets other lines.end' do
                assert_equal 17, issue_json['other_locations'].first['lines']['end']
              end
            end
          end
        end
      end
    end
  end
end
