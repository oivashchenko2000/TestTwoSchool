<aura:application description="messageRunner">
	<c:lts_jasmineRunner testFiles="{!join(',',
     $Resource.bindTest
    )}" />
</aura:application>
