//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require_tree ./store_managers
//= require moment
//= require fullcalendar

$('#calendar').fullCalendar({
        // ヘッダーのタイトルとボタン
        header: {
            // title, prev, next, prevYear, nextYear, today
            left: 'prev,next today',
            center: 'title',
            right: 'month agendaWeek agendaDay'
        },
        dayClick: function () {
            //ここにモーダルで詳細表示
            alert('日付クリックイベント');
        },
        // イベントソース(ここにAPI情報を記載)
        eventSources: [
            {
                events: [
                    {
                        title: 'event1',
                        start: '2020-06-02'
                    },
                    {
                        title: 'event2',
                        start: '2013-01-02',
                        end: '2013-01-03'
                    },
                    {
                        title: 'event3',
                        start: '2013-01-05 12:30:00',
                        allDay: false // will make the time show
                    }
                ]
            }
        ],
        
        // ボタン文字列
        buttonText: {
            today:    '今日',
            month:    '月',
            week:     '週',
            day:      '日'
        },
        
});
    
   