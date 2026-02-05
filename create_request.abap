CLASS zzcl_leave_manager_25 DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS create_request
      IMPORTING
        iv_emp_id     TYPE zemp_id
        iv_start_date TYPE dats
        iv_end_date   TYPE dats
        iv_type       TYPE char15
      EXPORTING
        ev_req_id     TYPE zzreqid_25.
ENDCLASS.

CLASS zzcl_leave_manager_25 IMPLEMENTATION.

  METHOD create_request.

    " date validation
    IF iv_start_date > iv_end_date.
      MESSAGE 'Invalid date range' TYPE 'E'.
    ENDIF.

    DATA: lv_req_id TYPE zzreqid_25.

    " generate next number
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr = '01'
        object      = 'ZLEAVE_REQ'
      IMPORTING
        number      = lv_req_id.

    " create work area
    DATA(ls_request) = VALUE zzleave_reqst_25(
          req_id     = lv_req_id
          emp_id     = iv_emp_id
          start_date = iv_start_date
          end_date   = iv_end_date
          leave_type = iv_type
          status     = 'PENDING' ).

    INSERT zzleave_reqst_25 FROM ls_request.

    IF sy-subrc <> 0.
      MESSAGE 'Failed to save leave request' TYPE 'E'.
    ENDIF.

    ev_req_id = lv_req_id.

  ENDMETHOD.

ENDCLASS.
