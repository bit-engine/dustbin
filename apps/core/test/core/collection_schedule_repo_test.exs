defmodule Core.CollectionScheduleRepoTest do
  use Core.Case

  test "collection schedule id and foreign keys should be type uuid" do
    collect_type = insert(:collect_type)
    location = insert(:supported_location)
    schedule = insert(
      :collection_schedule,
      collect_type: collect_type,
      supported_location: location
    )
    
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.id
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.collect_type_id
    <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = schedule.supported_location_id

    assert schedule.collect_type_id == collect_type.id
    assert schedule.supported_location_id == location.id
  end
end
