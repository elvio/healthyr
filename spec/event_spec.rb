require 'spec_helper'

module Healthyr
  describe Event do
    let(:transaction_id) { "38bb3fae1c76bbfb5c1c" }
    let(:starts) { 1363158057 }
    let(:ends) { 1363158067 }
    let(:args) { [event_type, starts, ends, transaction_id, payload] }
    let(:duration) { 10000.0 }

    subject { Event.new(*args).to_hash }

    context 'database event' do
      let(:sql_query) { %q{SELECT "users".* FROM "users"} }
      let(:event_type) { "sql.active_record" }
      let(:payload) { Hash[sql: sql_query] }

      it { should == Hash[name: 'database', value: sql_query, time: {total: duration}]}
    end

    context 'view event' do
      let(:event_type) { '!render_template.action_view' }
      let(:view_path) { 'users/index' }
      let(:payload) { Hash[virtual_path: view_path] }

      it { should == Hash[name: 'view', value: view_path, time: {total: duration}]}
    end

    context 'controller event' do
      let(:event_type) { 'process_action.action_controller' }
      let(:view_runtime) { 10.4 }
      let(:db_runtime) { 1.98 }
      let(:payload) { Hash[controller: 'UsersController', action: 'index', view_runtime: view_runtime, db_runtime: db_runtime] }

      it { should == Hash[name: 'controller', value: 'UsersController#index', time: {total: duration, view: view_runtime, db: db_runtime}] }
    end
  end
end
