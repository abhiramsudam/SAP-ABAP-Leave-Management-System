CLASS zzcl_leave_manager_25 DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS reject_request
      IMPORTING
        iv_req_id TYPE zzreqid_25.
ENDCLASS.

CLASS zzcl_leave_manager_25 IMPLEMENTATION.

  METHOD reject_request.

    DATA: ls_request TYPE zzleave_reqst_25.

    SELECT SINGLE *
      INTO ls_request
      FROM zzleave_reqst_25
      WHERE req_id = iv_req_id.

    IF sy-subrc <> 0.
      MESSAGE 'Leave request not found' TYPE 'E'.
      RETURN.
    ENDIF.

    ls_request-status = 'REJECTED'.

    UPDATE zzleave_reqst_25 FROM ls_request.

    IF sy-subrc = 0.
      MESSAGE 'Leave Request Rejected.' TYPE 'S'.
    ELSE.
      MESSAGE 'Failed to reject request' TYPE 'E'.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
