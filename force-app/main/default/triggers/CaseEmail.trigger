trigger CaseEmail on Case (after insert) {
         CaseShare caseShare = new CaseShare();
            caseShare.CaseId = trigger.new[0].Id;
            caseShare.UserOrGroupId = UserInfo.getUserId();
           // caseShare.RowCause = Schema.CaseShare.RowCause.SharingReason; // Use the Sharing Reason you created.
            caseShare.CaseAccessLevel = 'Read'; // Specify the access level (Edit, Read, etc.).

        // Insert the CaseShare record to share the case.
        //Database.SaveResult sr = Database.insert(caseShare);

}