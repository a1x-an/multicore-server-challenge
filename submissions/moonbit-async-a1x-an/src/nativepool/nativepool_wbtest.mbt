///|
test "pool leases use N connections concurrently" {
  let q = LeaseBook::new(3)
  assert_true(q.acquire() is Some(0))
  assert_true(q.acquire() is Some(1))
  assert_true(q.acquire() is Some(2))
}

///|
test "pool N plus one waits until release" {
  let q = LeaseBook::new(2)
  ignore(q.acquire())
  ignore(q.acquire())
  assert_true(q.acquire() is None)
  q.release(0)
  assert_true(q.acquire() is Some(0))
}

///|
test "discarded connection is replaced" {
  let q = LeaseBook::new(2)
  ignore(q.acquire())
  ignore(q.acquire())
  q.discard(0)
  assert_true(q.acquire() is Some(1))
}
