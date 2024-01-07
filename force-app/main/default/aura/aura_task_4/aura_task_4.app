<aura:application extends="force:slds">
    <aura:attribute name="Task1" type="boolean" default="true"/>
    <aura:attribute name="Task2" type="boolean" default="false"/>
    <aura:attribute name="Task3" type="boolean" default="false"/>
    <aura:attribute name="Task5" type="boolean" default="false"/>

    <div class="slds-align_absolute-center">
    <lightning:button label="Previous" onclick="{!c.previous}"></lightning:button>
    <lightning:button label="Next" onclick="{!c.next}"></lightning:button>
    </div>

    <aura:renderIf isTrue="{!v.Task1}">
        <c:Aura_task_1/>
    </aura:renderIf>

    <aura:renderIf isTrue="{!v.Task2}">
        <c:Aura_task_2/>
    </aura:renderIf>

    <aura:renderIf isTrue="{!v.Task3}">
        <c:Aura_task_3/>
    </aura:renderIf>

    <aura:renderIf isTrue="{!v.Task5}">
        <!-- <c:Aura_task_1> -->
    </aura:renderIf>

</aura:application>