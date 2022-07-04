report 50061 "New Orders Report"
{
    Caption = 'New Orders Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.src/rdlc/rep50061.new-orders.rdlc';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where(Status = filter(= 0));
            column(HeadOrderCustomerName; "Sell-to Customer Name") { }
            column(HeadOrderNumber; "No.") { }
            column(HeadOrderSAPNumber; "External Document No.") { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(LineOrderItemNr; "No.") { }
                column(LineOrderQty; Quantity) { }
                column(LineOederRequestedDate; "Planned Shipment Date") { }
                column(LineOrderItemDesc; Description) { }

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
} // report
