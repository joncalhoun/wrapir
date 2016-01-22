require File.expand_path('../../test_helper', __FILE__)

class Wrapir
  class PathBuilderTest < ::Test::Unit::TestCase

    setup do
      @path_values = {
        :id => 'fake-id',
        :id_prefix => 'fake-id-prefix'
      }
    end

    should 'raise an error when a key is missing' do
      assert_raise ArgumentError do
        PathBuilder.build('/test/:test_value', {})
      end
    end

    should 'replace all keys' do
      path = '/object/:id_prefix/:id'
      expected = '/object/fake-id-prefix/fake-id'
      assert_equal(expected, PathBuilder.build(path, @path_values))
    end

    should 'work even with extra path values' do
      path = '/object/:id'
      expected = '/object/fake-id'
      assert_equal(expected, PathBuilder.build(path, @path_values))
    end

  end
end
