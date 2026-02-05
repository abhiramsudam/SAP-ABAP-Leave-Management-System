CLASS zzcl_leave_manager_25 DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS get_emp_requests
      IMPORTING
        iv_emp_id   TYPE zemp_id
      EXPORTING
        et_requests TYPE STANDARD TABLE OF zzleave_reqst_25.
ENDCLASS.

CLASS zzcl_leave_manager_25 IMPLEMENTATION.

  METHOD get_emp_requests.

    SELECT *
      FROM zzleave_reqst_25
      INTO TABLE et_requests
      WHERE emp_id = iv_emp_id.

  ENDMETHOD.

ENDCLASS.
