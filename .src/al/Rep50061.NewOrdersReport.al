report 50061 "New Orders Report"
{
    Caption = 'New Orders Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.src/rdlc/rep50061.new-orders.rdlc';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(CompName; "Company Information".Name) { }
        } // company info
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where(Status = filter(= 0));
            column(HeadOrderCustomerName; "Sell-to Customer Name") { }
            column(HeadOrderNumber; "No.") { }
            column(HeadOrderSAPNumber; "External Document No.") { }
            column(HeadOrderIssue; "Posting Date") { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(LineOrderItemNr; "No.") { }
                column(LineOrderQty; Quantity) { }
                column(LineOederRequestedDate; "Planned Shipment Date") { }
                column(LineOrderItemDesc; Description) { }

                trigger OnAfterGetRecord()
                begin
                    if RqpItemNumber <> '' then
                        "Sales Line".SetFilter("No.", '=%1', RqpItemNumber);

                end;

            } // sales line

        } // sales header

    } //dataset
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Setup';
                    field(RqpOrderStatus; RqpOrderStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Order status';
                    }
                    field(RqpItemNumber; RqpItemNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Item number';
                    }
                }
            }
        } // layout
        actions
        {
            area(processing)
            {
            }
        } // actions
    } // requestpage
    labels
    {
        LblConfirmedDate = 'Confirmation date';
        LblIssueDate = 'Order received:';
        LblCustNameReqDate = 'Customer name / Requested date';
        LblSAPOrderNumberItemNumber = 'SAP requested date / Item number';
        LblPostingDateITemDescription = 'Posting date / Item desctription';
        LblOrderNumberConfirmDate = 'Order number / Conf. date';
        LblQty = 'Ordered quantity';
        LblPage = 'Page :';
        LblReportTitle = 'New orders report';

    } //labels
    var
        RqpOrderStatus: Option;
        RqpItemNumber: Code[20];

} // report
