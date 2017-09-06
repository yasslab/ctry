# those test casees are taken from active_support
# https://github.com/rails/rails/blob/v4.2.7.1/activesupport/test/core_ext/object/try_test.rb
#
# Copyright (c) 2005-2014 David Heinemeier Hansson
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
require 'ctry'
require 'test-unit'

class ObjectTryTest < Test::Unit::TestCase
  def setup
    @string = "Hello"
  end

  def test_nonexisting_method
    method = :undefined_method
    assert !@string.respond_to?(method)
    assert_nil @string.try(method)
  end

  def test_nonexisting_method_with_arguments
    method = :undefined_method
    assert !@string.respond_to?(method)
    assert_nil @string.try(method, 'llo', 'y')
  end

  def test_nonexisting_method_bang
    method = :undefined_method
    assert !@string.respond_to?(method)
    assert_raise(NoMethodError) { @string.try!(method) }
  end

  def test_nonexisting_method_with_arguments_bang
    method = :undefined_method
    assert !@string.respond_to?(method)
    assert_raise(NoMethodError) { @string.try!(method, 'llo', 'y') }
  end

  def test_valid_method
    assert_equal 5, @string.try(:size)
  end

  def test_argument_forwarding
    assert_equal 'Hey', @string.try(:sub, 'llo', 'y')
  end

  def test_block_forwarding
    assert_equal 'Hey', @string.try(:sub, 'llo') { |match| 'y' }
  end

  def test_nil_to_type
    assert_nil nil.try(:to_s)
    assert_nil nil.try(:to_i)
  end

  def test_false_try
    assert_equal 'false', false.try(:to_s)
  end

  def test_try_only_block
    assert_equal @string.reverse, @string.try { |s| s.reverse }
  end

  def test_try_only_block_bang
    assert_equal @string.reverse, @string.try! { |s| s.reverse }
  end

  def test_try_only_block_nil
    ran = false
    nil.try { ran = true }
    assert_equal false, ran
  end

  def test_try_with_instance_eval_block
    assert_equal @string.reverse, @string.try { reverse }
  end

  def test_try_with_instance_eval_block_bang
    assert_equal @string.reverse, @string.try! { reverse }
  end

  def test_try_with_private_method_bang
    klass = Class.new do
      private

      def private_method
        'private method'
      end
    end

    assert_raise(NoMethodError) { klass.new.try!(:private_method) }
  end

  def test_try_with_private_method
    klass = Class.new do
      private

      def private_method
        'private method'
      end
    end

    assert_nil klass.new.try(:private_method)
  end
end
