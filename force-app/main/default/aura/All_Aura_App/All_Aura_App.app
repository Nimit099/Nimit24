<aura:application extends="force:slds">
    <aura:attribute name="task1" type="Boolean" default="true"/>
    <aura:attribute name="task2" type="Boolean"/>
    <aura:attribute name="task3" type="Boolean"/>
    <aura:attribute name="task5" type="Boolean"/>

    <lightning:card>
    <lightning:input type="toggle" label="Task 1" checked="{!v.task1}" onchange="{!c.task1}"></lightning:input>
    <lightning:input type="toggle" label="Task 2" checked="{!v.task2}" onchange="{!c.task2}"></lightning:input>
    <lightning:input type="toggle" label="Task 3" checked="{!v.task3}" onchange="{!c.task3}"></lightning:input>
    <lightning:input type="toggle" label="Task 5" checked="{!v.task5}" onchange="{!c.task5}"></lightning:input>
    </lightning:card>
    <aura:renderIf isTrue="{!v.task1}">
        <c:Aura_task_1></c:Aura_task_1>
    </aura:renderIf>
    <aura:renderIf isTrue="{!v.task2}">
        <c:Aura_task_2></c:Aura_task_2>
    </aura:renderIf>
    <aura:renderIf isTrue="{!v.task3}">
        <c:Aura_task_3></c:Aura_task_3>
    </aura:renderIf>
    <aura:renderIf isTrue="{!v.task5}">
        <c:Aura_task_5></c:Aura_task_5>
    </aura:renderIf>
</aura:application>