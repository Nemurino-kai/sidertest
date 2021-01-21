# 第八章の内容を用いたコード

require 'minitest/autorun'
require '../lib/simple_event'
require '../lib/detailed_event'
require 'timecop'

class EventTimeDifferenceTest < Minitest::Test
  def test_time_difference_for_simple_event
    # 日付に依存するテストなので、 外部gemによりDate.today を2020/1/1に固定することで、日付への依存をなくしている。
    Timecop.travel(Date.new(2021, 1, 1))
    simple_event = SimpleEvent.new 'GA technologies 面談日'
    assert_equal "差は0日です", simple_event.calculate_time_difference
    simple_event = SimpleEvent.new 'GA technologies 面談日', Date.parse('2021/1/30')
    assert_equal "差は29日です", simple_event.calculate_time_difference
  end

  def test_time_difference_for_detailed_event
    Timecop.travel(Date.new(2021,1,1))
    detailed_event = DetailedEvent.new 'GA technologies 面談日', 'Aさんと面談を一時間行う', '田代弘平'
    assert_equal "差は0日です", detailed_event.calculate_time_difference
    detailed_event = DetailedEvent.new 'GA technologies 面談日', 'Aさんと面談を一時間行う', '田代弘平', Date.parse('2021/1/30')
    assert_equal "差は29日です", detailed_event.calculate_time_difference
  end
end
