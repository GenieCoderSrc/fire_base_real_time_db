enum QueryType {
  // No Value
  orderByChild,

  // No Field
  limitToFirst, // int value
  limitToLast, // int value
  // No Field, No Value
  orderByKey,
  orderByValue,
  orderByPriority,

  // Optional Field
  equalTo,
  startAt,
  endAt,
}
