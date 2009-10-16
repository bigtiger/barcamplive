def venue(name)
  Venue.create(:name => name)
end

def talks(venue, starts_at, ends_at, length=30.minutes)
  while starts_at < ends_at do
    venue.talks.create(:starts_at => starts_at, :ends_at => starts_at + length)
    starts_at = starts_at + length
  end
end

def topic(name, starts_at)
  Talk.find_all_by_starts_at(starts_at).each do |venue|
    venue.update_attributes(:topic => name)
  end
end

namespace :populate do
  desc "Populate the database with venues"
  task '2009' => :environment do
    date = Date.new(2009, 10, 18)

    room_1 = venue("Conference Room #1")
    room_2 = venue("Conference Room #2")
    room_3 = venue("Conference Room #3")

    talks(room_1, date + 9.hours + 30.minutes, date + 13.hours)
    talks(room_1, date + 13.hours, date + 14.hours, 1.hour)
    talks(room_1, date + 14.hours, date + 16.hours)
    talks(room_1, date + 16.hours, date + 18.hours, 10.minutes)

    [room_2, room_3].each do |venue|
      talks(venue, date + 10.hours, date + 13.hours)
      talks(venue, date + 13.hours, date + 14.hours, 1.hour)
      talks(venue, date + 14.hours, date + 18.hours)
    end

    topic("Registration", date + 9.hours + 30.minutes)
  end
end
